//
//  CookbookDetailView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/22/23.
//

import SwiftUI

struct CookbookDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var coreVM: CoreVM
    @State private var recipeNote = ""
    @State private var isSaved = true
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    self.image
                    self.tags
                    self.ingredients
                    self.instructions
                    self.nutritionInfo
                    self.notes
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
            }
            .scrollIndicators(.never)
        }
        .onAppear {
            recipeNote = recipe.unwrappedNote
        }
        .alert(isPresented: $coreVM.triggerAlert, content: {
            Alert(
                title: Text("Alert"),
                message: Text(coreVM.alertMessage),
                dismissButton: .default(Text("OK")) {
                coreVM.triggerAlert = false
                coreVM.alertMessage = ""
            })
        })
        .navigationBar(recipe.unwrappedName)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                SaveButtonView(isSaved: self.$isSaved) {
                    unsave()
                }
            }
        }
    }
}

extension CookbookDetailView {
    private var image: some View {
        RowViewImage(
            url: recipe.unwrappedImage,
            height: 175
        )
        .padding(.horizontal, 5)
    }
    
    private var tags: some View {
        ScrollView(.horizontal) {
            HStack {
                RecipeTagScrollView(cuisine: recipe.unwrappedCuisine, dish: recipe.unwrappedDish, totalTime: Int(recipe.time), servings: Int(recipe.servings))
            }
        }
        .padding(.bottom, 10)
        .scrollIndicators(.never)
    }
    
    private var ingredients: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .header()
            
            ForEach(recipe.ingredientsArray, id: \.id) { ingredient in
                Text("• \(ingredient.unwrappedIngredient)")
                    .padding(.bottom, 1)
                    .font(.oswald(size: 20))
            }
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 5)
    }
    
    private var instructions: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .header()
            
            ForEach(recipe.instructionsArray, id: \.id) { instruction in
                VStack(alignment: .leading) {
                    Text("Step \(instruction.step)")
                        .font(.oswaldBold(size: 20))
                        .padding(.bottom, 3)
                    Text(instruction.unwrappedInstructions)
                        .font(.oswald(size: 20))
                        .padding(.bottom, 5)
                }
            }
        }
        .padding(.horizontal, 15)
    }
    
    private var nutritionInfo: some View {
        VStack {
            Text("Nutrition")
                .header()
            
            ForEach(recipe.nutrientsArray, id: \.id) { nutrient in
                CookBookIngredientInformation(nutrient: nutrient)
            }
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 5)
    }
    
    private var notes: some View {
        VStack {
            Text("Notes")
                .header()
            
            TextEditor(text: self.$recipeNote)
                .cornerRadius(20)
                .frame(height: 175)
                .shadow(color: Color.black.opacity(0.5), radius: 1)
                .onChange(of: recipeNote) { updatedNote in
                    coreVM.updateNote(withText: updatedNote, forRecipe: recipe)
                }
        }
        .padding(.bottom)
        .padding(.horizontal, 15)
    }
}

extension CookbookDetailView {
    private func unsave() {
        coreVM.unsaveRecipe(name: recipe.unwrappedName)
        self.isSaved = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
           dismiss()
        }
    }
}



