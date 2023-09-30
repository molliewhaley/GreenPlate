//
//  RecipeRowView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import SwiftUI

struct RecipeRowView: View {
    let urlString: String
    let name: String
    
    var body: some View {
        ZStack {
            RowViewImage(url: urlString, height: 175)
            Text(name)
                .recipeRowText()
        }
    }
}

