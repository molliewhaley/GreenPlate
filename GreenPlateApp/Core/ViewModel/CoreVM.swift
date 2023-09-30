//
//  CookbookVM.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/22/23.
//

import Foundation
import CoreData

class CoreVM: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var recipeArray: [Recipe] = []
    @Published var triggerAlert = false
    @Published var alertMessage = ""
    
    func getRecipes() async {
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        let sortDescriptor = NSSortDescriptor(key: "dateSaved", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            let request = try viewContext.fetch(request)
            DispatchQueue.main.async {
                self.recipeArray = request
            }
        } catch {
            triggerAlert = true
            alertMessage = "Problem finding saved recipes."
        }
    }
    
    func saveRecipe(usingRecipe apiRecipe: RecipeResults) {
        if !recipeAlreadySaved(name: apiRecipe.title) {
            let coreRecipe = Recipe(context: viewContext)
            saveRecipeValues(apiRecipe: apiRecipe, coreRecipe: coreRecipe)
            saveNutrient(apiRecipe: apiRecipe, coreRecipe: coreRecipe)
            saveIngredients(apiRecipe: apiRecipe, coreRecipe: coreRecipe)
            saveInstructions(apiRecipe: apiRecipe, coreRecipe: coreRecipe)
            save()
            
        } else {
            print("debug - saved recipe showing up in new search.")
        }
    }
    
    private func saveRecipeValues(apiRecipe: RecipeResults, coreRecipe: Recipe) {
        coreRecipe.name = apiRecipe.title
        coreRecipe.cuisine = apiRecipe.unwrappedCuisine
        coreRecipe.dishType = apiRecipe.unwrappedDish
        coreRecipe.image = apiRecipe.image
        coreRecipe.servings = Int16(apiRecipe.servings)
        coreRecipe.time = Int16(apiRecipe.readyInMinutes)
        coreRecipe.note = ""
        coreRecipe.id = UUID()
        coreRecipe.dateSaved = Date()
    }
    
    private func saveNutrient(apiRecipe: RecipeResults, coreRecipe: Recipe) {
        let nutrientsToSave = ["Calories", "Carbohydrates", "Protein", "Sugar"]
        for nutrient in apiRecipe.nutrition.nutrients {
            if nutrientsToSave.contains(nutrient.name) {
                let coreNutrients = Nutrients(context: viewContext)
                coreNutrients.id = UUID()
                coreNutrients.name = nutrient.name
                coreNutrients.amount = Int16(nutrient.amount)
                coreNutrients.units = nutrient.unit
                coreRecipe.addToNutrients(coreNutrients)
            }
        }
    }
    
    private func saveIngredients(apiRecipe: RecipeResults, coreRecipe: Recipe) {
        for ingredient in apiRecipe.nutrition.ingredients {
            let coreIngredients = Ingredients(context: viewContext)
            coreIngredients.id = UUID()
            coreIngredients.ingredient =  ingredient.name
            coreRecipe.addToIngredients(coreIngredients)
        }
    }
    
    func saveInstructions(apiRecipe: RecipeResults, coreRecipe: Recipe) {
        for instructionSteps in apiRecipe.analyzedInstructions {
            for step in instructionSteps.steps {
                let coreInstructions = Instructions(context: viewContext)
                coreInstructions.id = UUID()
                coreInstructions.instruction = step.step
                coreInstructions.step = Int16(step.number)
                coreRecipe.addToInstructions(coreInstructions)
            }
        }
    }
    
    func recipeAlreadySaved(name: String) -> Bool {
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let matchingRecipes = try viewContext.fetch(request)
            return !matchingRecipes.isEmpty
        } catch {
            print("Error fetching recipes.")
            return false
        }
    }

    func unsaveRecipe(name: String) {
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            guard let matchingRecipe = try viewContext.fetch(request).first else { return }
            viewContext.delete(matchingRecipe)
            save()
        } catch {
            print("Error deleting")
        }
    }
    
    func updateNote(withText text: String, forRecipe recipe: Recipe) {
        recipe.note = text
        save()
    }
    
    func getIngredients(recipe: RecipeResults) -> [String] {
        let uniqueIngredients = Array(Set(recipe.nutrition.ingredients))
        let sortedIngredientNames = uniqueIngredients.map { $0.name }.sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
        return sortedIngredientNames
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            triggerAlert = true
            alertMessage = "Problem saving changes."
        }
    }
}
