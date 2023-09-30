//
//  ProfileImageview.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/10/23.
//

import SwiftUI

struct ProfileImageView: View {
    let review: ReviewDetails
    
    var body: some View {
        if let url = URL(string: review.user.unwrappedImageUrl) {
            AsyncImage(url: url) { image in
                image
                    .profileImage()
            } placeholder: {
                Image("ImagePlaceholder")
                    .profileImage()
            }
        } else {
            Image("ImagePlaceholder")
                .profileImage()
        }
    }
}

