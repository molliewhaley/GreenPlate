//
//  RestaurantInformationView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/9/23.
//

import SwiftUI

struct RestaurantInformationView: View {
    let image: String
    let content: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .foregroundColor(.customGreen)
            Text(content)
                .font(.oswaldBold(size: 18))
        }
    }
}
