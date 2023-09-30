//
//  CookbookIngredientInfo.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/22/23.
//

import SwiftUI

struct CookBookIngredientInformation: View {
    let nutrient: Nutrients

    var body: some View {
        HStack {
            Text("\(nutrient.unwrappedName): ")
                .font(.oswaldBold(size: 20))
            Text("\(nutrient.amount) \(nutrient.unwrappedUnit)")
                .font(.oswald(size: 20))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 1)
    }
}

