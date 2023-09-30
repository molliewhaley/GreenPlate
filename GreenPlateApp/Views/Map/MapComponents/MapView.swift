//
//  MapView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/9/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var mapVM: MapVM
    let restaurants: [Restaurants]
    
    var body: some View {
        Map(
            coordinateRegion: Binding<MKCoordinateRegion>(
            get: { mapVM.restaurantRegion },
            set: { _ in }
        ), annotationItems: restaurants) { restaurant in
            MapAnnotation(coordinate: restaurant.coordinates.locationCoordinates) {
                self.restaurantCircle(restaurant: restaurant)
            }
        }
    }
}

extension MapView {
    private func restaurantCircle(restaurant: Restaurants) -> some View {
        Image(systemName: "circle.fill")
            .font(.system(size: 20))
            .foregroundColor(Color.customGreen)
            .overlay {
                Circle()
                    .stroke(Color.white, lineWidth: 3)
            }
            .onTapGesture {
                mapVM.userTappedPin(
                    restaurantArray: restaurants,
                    restaurant: restaurant
                )
            }
    }
}

