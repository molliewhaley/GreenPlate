//
//  ProductImageView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/12/23.
//

import SwiftUI

struct ProductImageView: View {
    let productURL: String
    
    var body: some View {
        if let url = URL(string: productURL) {
            AsyncImage(url: url) { image in
                image
                    .productImage()
            } placeholder: {
                Image("ImagePlaceholder")
                    .productImage()
            }
        } else {
            Image("ImagePlaceholder")
                .productImage()
        }
    }
}

