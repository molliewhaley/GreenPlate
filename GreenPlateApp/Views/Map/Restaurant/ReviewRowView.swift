//
//  RestaurantRowView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/3/23.
//

import Foundation
import SwiftUI

struct ReviewRowView: View {
    let review: ReviewDetails
    let restaurantFinderVM: RestaurantFinderVM
    
    var body: some View {
        Link(destination: URL(string: review.url)!) {
            self.fullReview
        }
    }
}

extension ReviewRowView {
   private var fullReview: some View {
        HStack(alignment: .top, spacing: 10) {
            self.reviewImage
            self.reviewInfo
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var reviewImage: some View {
        ProfileImageView(
            review: review
        )
    }
    
    private var reviewInfo: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Text(review.user.name)
                    .font(.oswaldBold(size: 18))
                
                HStack {
                    review.reviewStars
                }
                .foregroundColor(.yellow)
            }
            Text(review.text)
                .font(.oswald(size: 18))
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 5)
        .foregroundColor(.black)
    }
}
