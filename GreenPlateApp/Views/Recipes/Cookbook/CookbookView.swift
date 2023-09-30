//
//  CookbookView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import SwiftUI

struct CookbookView: View {
    @ObservedObject var coreVM: CoreVM
    
    var body: some View {
        NavigationStack {
            ZStack {
                if coreVM.recipeArray.isEmpty {
                    self.emptyView
                }
                self.scrollView
            }
            .navigationBar("GreenPlate")
            .onAppear {
                Task {
                    await coreVM.getRecipes()
                }
            }
        }
    }
}

extension CookbookView {
    private var emptyView: some View {
        
        EmptyContentView(
            message: "Saved recipes will appear here.",
            image: "heart.fill"
        )
    }
    
    private var scrollView: some View {
        VStack {
            ScrollView {
                ForEach(coreVM.recipeArray, id: \.recipeID) { recipe in
                    NavigationLink(destination: CookbookDetailView(recipe: recipe)) {
                        RecipeRowView(urlString: recipe.unwrappedImage, name: recipe.unwrappedName)
                    }
                }
            }
            .scrollIndicators(.never)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
