//
//  RecipeView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import SwiftUI

struct SearchRecipesView: View {
    @StateObject private var searchRecipesVM = SearchRecipesVM()
    @State private var searchText = ""
    let coreVM: CoreVM
    
    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                ZStack {
                    if searchRecipesVM.displayBlank {
                        self.emptyView
                    }
                    VStack {
                        self.searchBar
                        self.recipesList
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .fullScreenCover(isPresented: $searchRecipesVM.recipesLoading) {
                        WalkingBroccoliView(loadingText: "Wandering through flavorful territories.")
                    }
                    .alert(isPresented: $searchRecipesVM.triggerAlert) {
                        Alert(title: Text("Error"), message: Text(searchRecipesVM.alertMessage), dismissButton: .default(Text("OK")) { searchRecipesVM.triggerAlert = false })
                    }
                }
                .navigationBar("GreenPlate")
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

extension SearchRecipesView {
    private var emptyView: some View {
        EmptyContentView(
            message: "Hungry for inspiration? Search to get started.",
            image: "carrot"
        )
    }
    
    private var searchBar: some View {
        SearchBarView(
            searchText: $searchText,
            searchDescription: "Recipes",
            handleSearch: handleSearch
        )
        .padding(.horizontal, 10)
    }
    
    private var recipesList: some View {
        ScrollView {
            ForEach(searchRecipesVM.unwrappedRecipes.results, id: \.id) { recipe in
                NavigationLink(destination: RecipeDetailView(searchRecipeVM: searchRecipesVM, coreVM: coreVM, recipe: recipe)) {
                    VStack {
                        RecipeRowView(urlString: recipe.image, name: recipe.title)
                    }
                }
            }
        }
        .scrollIndicators(.never)
    }
}

extension SearchRecipesView {
    private func handleSearch() {
        Task {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            await searchRecipesVM.searchRecipes(withDescription: searchText)
            self.searchText = ""
        }
    }
}

