//
//  RestaurantDetailView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/2/23.
//

import SwiftUI

struct RestaurantView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var extraRestaurantDetailsVM = ExtraRestaurantDetailsVM()
    let restaurant: Restaurants
    let restaurantFinderVM: RestaurantFinderVM
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack(spacing: 24) {
                            RowViewImage(
                                url: restaurant.imageUrl,
                                height: 175
                            )
                            .padding(.horizontal, 5)
                            
                            RestaurantTags(
                                geometry: geometry,
                                restaurant: restaurant
                            )
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading, spacing: 18) {
                            self.ratingAndPrice
                            self.restaurantInfo
                            self.reviews
                        }
                        .padding(.horizontal, 15)
                    }
                    Spacer()
                }
                .scrollIndicators(.never)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 10)
            }
        }
        .alert(isPresented: $extraRestaurantDetailsVM.triggerAlert) {
            Alert(
                title: Text("Error"),
                message: Text(extraRestaurantDetailsVM.alertMessage),
                dismissButton: .default(Text("OK")) {
                    extraRestaurantDetailsVM.triggerAlert = false
                })
        }
        .navigationBar(restaurant.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }
        }
        .onAppear {
            Task {
                await extraRestaurantDetailsVM.getTimes(fromId: restaurant.id)
                await extraRestaurantDetailsVM.getReviews(fromId: restaurant.id)
            }
        }
    }
}

extension RestaurantView {
    private var ratingAndPrice: some View {
        HStack {
            restaurant.stars
            restaurant.formattedPrice
                .padding(.leading, 20)
                .foregroundColor(.yellow)
        }
        .font(.system(size: 18))
        .padding(.top, 8)
    }
    
    private var restaurantInfo: some View {
        VStack(alignment: .leading, spacing: 15) {
            RestaurantInformationView(
                image: "phone.fill",
                content: restaurant.displayPhone
            )
            RestaurantInformationView(
                image: "location.fill",
                content: restaurant.location.address
            )
            RestaurantInformationView(
                image: "clock.fill",
                content: extraRestaurantDetailsVM.formattedHours
            )
        }
        .padding(.vertical, 17)
    }
    
    private var reviews: some View {
        VStack {
            Text("Reviews:")
                .header()
            ForEach(extraRestaurantDetailsVM.reviewsArray, id: \.id) { review in
                ReviewRowView(
                    review: review,
                    restaurantFinderVM: restaurantFinderVM
                )
                .padding(5)
            }
        }
    }
}
    
struct RestaurantTags: View {
    let geometry: GeometryProxy
    let restaurant: Restaurants
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Spacer()
                ForEach(restaurant.categories, id: \.self) { category in
                    Text(category.title)
                        .scrollViewTag()
                }
                Spacer()
            }
            .frame(minWidth: geometry.size.width)
        }
        .padding(.bottom, 8)
    }
}
    

