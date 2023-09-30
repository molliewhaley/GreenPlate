//
//  NutrientInformation.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import SwiftUI

struct IngredientInformation: View {
    let nutrient: String
    let recipe: RecipeResults
    let units: String
    
    var recipeAmount: Int {
        return Int(recipe.nutrition.nutrients.first(where: { $0.name == nutrient })?.amount ?? 0)
    }
    
    var body: some View {
        HStack {
            Text("\(nutrient): ")
                .font(.oswaldBold(size: 20))
            Text("\(recipeAmount) \(units)")
                .font(.oswald(size: 18))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 1)
    }
}

