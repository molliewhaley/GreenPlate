//
//  RecipeVM.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import Foundation
import CoreData

@MainActor final class SearchRecipesVM: ObservableObject {
    @Published var recipes: ApiRecipes? 
    @Published var triggerAlert = false
    @Published var alertMessage = ""
    @Published var recipesLoading = false
    private let viewContext = PersistenceController.shared.viewContext
    private let apiClient = RecipeApiClient()
    
    var displayBlank: Bool {
        return self.triggerAlert == false && self.recipes == nil
    }
    
    var unwrappedRecipes: ApiRecipes {
        return recipes ?? ApiRecipes(results: [RecipeResults]())
    }
    
    func searchRecipes(withDescription description: String) async {
        if description != "" {
            do {
                self.recipesLoading = true
                let recipeData = try await apiClient.searchRecipes(withDescription: description)
                let filteredRecipes = filterSavedRecipes(fromApiRecipes: recipeData)
                self.recipes = filteredRecipes
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.recipesLoading = false
                }
            } catch ApiError.invalidURL {
                self.recipesLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.triggerAlert = true
                    self.alertMessage = "Unresolved issue. We're working on fixing it."
                }
            } catch ApiError.invalidResponse {
                self.recipesLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.triggerAlert = true
                    self.alertMessage = "Server error. Try again later."
                }
            } catch ApiError.invalidData {
                self.recipesLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.triggerAlert = true
                    self.alertMessage = "Problem finding recipes. Try again."
                }
            } catch ApiError.invalidSearch {
                self.recipesLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.triggerAlert = true
                    self.alertMessage = "Invalid input. Check spelling or try another keyword."
                }
            } catch {
                self.recipesLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.triggerAlert = true
                    self.alertMessage = "Unexpected problem. Try again."
                }
            }
        } else {
                self.triggerAlert = true
                self.alertMessage = "Empty text field."
        }
        
        func filterSavedRecipes(fromApiRecipes apiRecipes: ApiRecipes) -> ApiRecipes {
            let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
            do {
                let savedRecipes = try viewContext.fetch(request)
                let savedRecipeNames = savedRecipes.map { $0.name }
                let filteredResults = apiRecipes.results.filter { apiRecipe in
                    !savedRecipeNames.contains(apiRecipe.title)
                }
                let unsavedRecipes = ApiRecipes(results: filteredResults)
                return filterInvalidInstructions(fromApiRecipe: unsavedRecipes)
            } catch {
                return apiRecipes
            }
        }
        
        func filterInvalidInstructions(fromApiRecipe apiRecipe: ApiRecipes) -> ApiRecipes {
            let excludedPhrase = "Recipe at my blog"
            let recipesWithoutPhrase = apiRecipe.results.filter { recipe in
                let containsExcludedPhrase = recipe.analyzedInstructions.contains { instructionSet in
                    instructionSet.steps.contains { step in
                        step.step.localizedCaseInsensitiveContains(excludedPhrase)
                    }
                }
                return !containsExcludedPhrase
            }
            return ApiRecipes(results: recipesWithoutPhrase)
        }
    }
}
