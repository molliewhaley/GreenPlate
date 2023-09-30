////
////  CarouselSectionView.swift
////  GreenPlateApp
////
////  Created by Mollie Whaley on 9/29/23.
////
import SwiftUI
//
struct CarouselSectionView: View {
    @ObservedObject var mapVM: MapVM
    let outerView: GeometryProxy
    let restaurantFinderVM: RestaurantFinderVM

    var body: some View {
        VStack {
            Spacer()
            if !mapVM.isUserInteracting {
                    HStack(spacing: 0) {
                        ForEach(restaurantFinderVM.restaurantArray, id: \.id) { restaurant in
                            CarouselCardView(
                                restaurantFinderVM: restaurantFinderVM,
                                restaurant: restaurant
                            )
                            .padding(.horizontal, 10)
                            .padding(.bottom, 15)
                            .frame(width: outerView.size.width)
                            .onTapGesture {
                                mapVM.usertappedCard(restaurant: restaurant)
                            }
                            .navigationDestination(isPresented: $mapVM.isCardTapped) {
                                if let tappedRestaurant = mapVM.restaurantTapped {
                                    RestaurantView(
                                        restaurant: tappedRestaurant,
                                        restaurantFinderVM: restaurantFinderVM
                                    )
                                }
                            }
                        }
                    }
            }
        }

    }
}
