//
//  MapVM.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/9/23.
//

import Foundation
import SwiftUI
import MapKit

@MainActor final class MapVM: ObservableObject {
    @Published var restaurantRegion: MKCoordinateRegion
    @Published var currentRestaurantCoordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @Published var tappedPinIndex = 0
    @Published var isCardTapped = false
    @Published var restaurantTapped: Restaurants?
    @Published var currentRestaurantCardIndex = 0
    @Published var searchText = ""
    @Published var isUserInteracting = false

    init(restaurantRegion: MKCoordinateRegion) {
        self.restaurantRegion = restaurantRegion
    }
    
    func userIsInteracting() {
        withAnimation {
            self.isUserInteracting = true
        }
    }
    
    func updateIndex() {
        self.currentRestaurantCardIndex = 0
    }
    
    func setRestaurantRegion(restaurantsArray restaurants: [Restaurants]) {
        if !restaurants.isEmpty {
            withAnimation(.easeInOut(duration: 3)) {
                    self.restaurantRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: restaurants[self.currentRestaurantCardIndex].coordinates.latitude, longitude: restaurants[self.currentRestaurantCardIndex].coordinates.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            }
        }
    }
    
    func handleUserSwipe(newIndex: Int, restaurants: [Restaurants]) {
        let index = (newIndex + restaurants.count) % restaurants.count
        self.currentRestaurantCardIndex = index
        withAnimation(.easeInOut(duration: 3)) {
            self.setRestaurantRegion(restaurantsArray: restaurants)
        }
    }
    
    func usertappedCard(restaurant: Restaurants) {
        self.restaurantTapped = restaurant
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isCardTapped = true
        }
    }
    
    func userTappedPin(restaurantArray restaurants: [Restaurants], restaurant: Restaurants) {
        withAnimation(.easeInOut(duration: 2)) {
            self.currentRestaurantCardIndex = restaurants.firstIndex(where: { $0.id == restaurant.id }) ?? 0
        }
        withAnimation {
            self.setRestaurantRegion(restaurantsArray: restaurants)
            self.isUserInteracting = false
        }
    }
}
