//
//  Recipes.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/16/23.
//

import Foundation

struct ApiRecipes: Codable {
    var results: [RecipeResults]
}

struct RecipeResults: Codable, Identifiable {
    let title: String
    let id: Int
    let image: String
    let readyInMinutes: Int
    let servings: Int
    let nutrition: NutritionProperties
    let cuisines: [String]?
    let dishTypes: [String]? 
    let analyzedInstructions: [ApiInstructions]
}

extension RecipeResults {
    var unwrappedCuisine: String {
        return cuisines?.first ?? ""
    }

    var unwrappedDish: String {
        return dishTypes?.first ?? ""
    }
}

struct NutritionProperties: Codable, Hashable {
    let nutrients: [Nutrient]
    let ingredients: [Nutrient]
}

struct Nutrient: Codable, Hashable {
    let name: String
    let amount: Double
    let unit: String
}

struct ApiInstructions: Codable, Hashable {
    let steps: [Steps]
}

struct Steps: Codable, Hashable {
    let number: Int
    let step: String
}

