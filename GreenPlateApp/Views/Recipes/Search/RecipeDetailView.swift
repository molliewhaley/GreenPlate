//
//  RecipeDetailView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var searchRecipeVM: SearchRecipesVM
    @ObservedObject var coreVM: CoreVM
    @State private var recipeNotes = ""
    @State private var isSaved = false
    let recipe: RecipeResults
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    self.image
                    self.tags
                    self.ingredients
                    self.instructions
                    self.nutrients
                }
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .font(.system(size: 20, design: .serif))
            }
            .scrollIndicators(.never)
        }
        .alert(isPresented: $coreVM.triggerAlert, content: {
            Alert(title: Text("Alert"), message: Text(coreVM.alertMessage), dismissButton: .default(Text("OK")) {
                coreVM.triggerAlert = false
                coreVM.alertMessage = ""
            })
        })
        .navigationBar(recipe.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                SaveButtonView(isSaved: $isSaved, handleSave: handleSave)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }
        }
    }
}

extension RecipeDetailView {
    private var image: some View {
        RowViewImage(
            url: recipe.image,
            height: 175
        )
        .padding(.horizontal, 5)
    }
    
    private var tags: some View {
        RecipeTagScrollView(
            cuisine: recipe.unwrappedCuisine,
            dish: recipe.unwrappedDish,
            totalTime: recipe.readyInMinutes,
            servings: recipe.servings
        )
        .scrollIndicators(.never)
    }
    
    private var ingredients: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Ingredients")
                    .header()
                
                ForEach(coreVM.getIngredients(recipe: recipe), id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .padding(.bottom, 1)
                        .font(.oswald(size: 20))
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 5)
        }
    }
    
    private var instructions: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .header()
            
            ForEach(recipe.analyzedInstructions, id: \.self) { instructions in
                ForEach(instructions.steps, id: \.number) { step in
                    VStack(alignment: .leading) {
                        Text("Step \(step.number)")
                            .font(.oswaldBold(size: 20))
                            .padding(.bottom, 3)
                        Text("\(step.step)")
                            .font(.oswald(size: 20))
                            .padding(.bottom, 5)
                    }
                }
            }
        }
        .padding(.horizontal, 15)
    }
    
    private var nutrients: some View {
        VStack {
            Text("Nutrition")
                .header()
            IngredientInformation(nutrient: "Calories", recipe: recipe, units: "Kcal")
            IngredientInformation(nutrient: "Carbohydrates", recipe: recipe, units: "g")
            IngredientInformation(nutrient: "Protein", recipe: recipe, units: "g")
            IngredientInformation(nutrient: "Sugar", recipe: recipe, units: "g")
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 5)
    }
}

extension RecipeDetailView {
    private func handleSave() {
        coreVM.saveRecipe(usingRecipe: recipe)
        if let index = searchRecipeVM.recipes?.results.firstIndex(where: { $0.title == recipe.title }) {
            self.searchRecipeVM.recipes?.results.remove(at: index)
        }
        self.isSaved = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            dismiss()
        }
    }
}
