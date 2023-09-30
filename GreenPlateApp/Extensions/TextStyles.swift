//
//  SharedTextExtension.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/9/23.
//

import Foundation
import SwiftUI

extension Text {
    func scrollViewTag() -> some View {
        self
            .font(.oswaldBold(size: 20))
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.customGreen)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
    
    func header() -> some View {
        self
            .font(.oswaldBold(size: 22))
            .padding(.bottom, 5)
            .foregroundColor(Color.customGreen)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func recipeRowText() -> some View {
        self
            .font(.oswald(size: 30))
            .foregroundColor(.white)
            .padding(.horizontal, 5)
            .frame(width: 250, height: 100)
            .background(Color.black)
            .cornerRadius(10)
    }
}


extension Font {
    static func oswald(size: CGFloat) -> Font {
        return Font.custom("Oswald-Regular", size: size)
    }
    
    static func oswaldBold(size: CGFloat) -> Font {
        return Font.custom("Oswald-Medium", size: size)
    }
}


