//
//  RecipeTagScrollView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/22/23.
//

import SwiftUI

struct RecipeTagScrollView: View {
    let cuisine: String
    let dish: String
    let totalTime: Int
    let servings: Int
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if !cuisine.isEmpty {
                    Text(cuisine)
                        .scrollViewTag()
                }
                if !dish.isEmpty {
                    Text(dish)
                        .scrollViewTag()
                }
                Text("\(totalTime) minutes")
                    .scrollViewTag()
                Text("\(servings) servings")
                    .scrollViewTag()
            }
            .padding(.horizontal)
        }
    }
}
