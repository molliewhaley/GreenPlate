//
//  ImageExt.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/10/23.
//

import Foundation
import SwiftUI

extension Image {
    func restaurantImage(withHeight height: Int) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(height: CGFloat(height)) 
            .clipped()
    }
    
    func profileImage() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 65, height: 65)
            .clipShape(Circle())
    }
    
    func productImage() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: CGFloat(Float(UIScreen.main.bounds.width)) / 1.5, height: 350)
            .cornerRadius(10)
            .clipped()
    }
    
    func searchImage() -> some View {
        self
            .font(.system(size: 22, weight: .medium))
            .foregroundColor(.black)
            .font(.system(size: 20))
            .padding(.leading, 10)
    }
    
    func asyncImageStyling(height: Int) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: CGFloat(height))
            .clipped()
    }
}
