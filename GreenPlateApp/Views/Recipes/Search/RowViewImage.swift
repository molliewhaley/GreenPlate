//
//  ImageRowView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/26/23.
//

import SwiftUI

struct RowViewImage: View {
    let url: String
    let height: Int
    
    var body: some View {
        if let url = URL(string: url) {
            AsyncImage(url: url) { image in
                image
                    .asyncImageStyling(height: height)
            } placeholder: {
                Image("ImagePlaceholder")
                    .asyncImageStyling(height: height)
            }
            
        } else {
            Image("ImagePlaceholder")
                .asyncImageStyling(height: height)
        }
    }
} 
