//
//  CarouselCardView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/2/23.
//

import SwiftUI

struct CarouselCardView: View {
    let restaurantFinderVM: RestaurantFinderVM
    let restaurant: Restaurants
    
    var body: some View {
        VStack(spacing: 0) {
            self.fullCard
            self.image
        }
        .background(Color.white)
        .contentShape(Rectangle())
        .frame(height: CGFloat(changeHeight(basedOnRestaurant: restaurant)))
        .cornerRadius(20)
    }
}

extension CarouselCardView {
    private var fullCard: some View {
        HStack {
            self.cardLeading
            Spacer()
            self.cardTrailing
        }
        .padding(.horizontal)
    }
    
    private var cardLeading: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(restaurant.name)
                .foregroundColor(.black)
                .font(.oswaldBold(size: 22))
            HStack {
                restaurant.stars
            }
            .foregroundColor(.yellow)
            .font(.system(size: 18))
            Spacer()
        }
        .padding(.top, 10)
    }
    
    private var cardTrailing: some View {
        VStack(alignment: .trailing, spacing: 12) {
            HStack {
                Text(restaurant.isClosed ? "Closed" : "Open")
                Image(systemName: "clock")
            }
            .foregroundColor(.black)
            .font(.oswaldBold(size: 18))
            
            restaurant.formattedPrice
            .foregroundColor(.yellow)
            .font(.system(size: 18))
            Spacer()
        }
        .padding(.top, 10)
    }
    
    private var image: some View {
        RowViewImage(
            url: restaurant.imageUrl,
            height: 100
        )
    }
}
extension CarouselCardView {
    private func changeHeight(basedOnRestaurant restaurant: Restaurants) -> Int {
        if restaurant.name.count > 18 {
            return 210
        } else {
            return 200
        }
    }
}



