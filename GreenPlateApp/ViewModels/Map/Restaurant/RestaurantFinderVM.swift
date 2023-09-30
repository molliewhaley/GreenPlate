//
//  RestaurantFinderVM.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/28/23.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

@MainActor
final class RestaurantFinderVM: ObservableObject {
    @Published var restaurantArray: [Restaurants] = [] 
    @Published var triggerAlert = false
    @Published var alertMessage = ""
    @Published var restaurantRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @Published var currentRestaurantCoordinates = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    private let apiClient = RestaurantApiClient()
    
    func findRestaurants(usingUrl url: String) async {
        do {
            let restaurantData = try await apiClient.getRestaurants(fromUrl: url)
            if let restaurantData = restaurantData {
                self.restaurantArray = restaurantData
                self.restaurantRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: restaurantData[0].coordinates.latitude, longitude: restaurantData[0].coordinates.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self.currentRestaurantCoordinates = CLLocationCoordinate2D(latitude: restaurantData[0].coordinates.latitude, longitude: restaurantData[0].coordinates.longitude)
            }
        } catch ApiError.invalidURL {
            self.triggerAlert = true
            self.alertMessage =  "Unresolved issue. We're working on fixing it"
        } catch ApiError.invalidResponse {
            self.triggerAlert = true
            self.alertMessage = "Server error. Try again later."
        } catch ApiError.invalidData {
            self.triggerAlert = true
            self.alertMessage = "Problem finding restaurants. Try again."
        } catch {
            self.triggerAlert = true
            self.alertMessage = "Unexpected problem. Try again."
        }
    }
    
    func generateUrlFromLocation() -> String {
        let latitude = restaurantRegion.center.latitude
        let longitude = restaurantRegion.center.longitude
        return "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&term=restaurants&radius=8046&categories=vegan&sort_by=best_match&limit=20"
    }
    
    func generateUrlFromSearch(searchLocation location: String) -> String {
        let spacelessLocation = location.replacingOccurrences(of: " ", with: "%20")
       return "https://api.yelp.com/v3/businesses/search?location=\(spacelessLocation)&term=restaurants&radius=8046&categories=vegan&sort_by=best_match&limit=20"
    }
    
    func getAddress(ofRestaurant restaurant: Restaurants) -> String {
        let addressArray = restaurant.location.displayAddress
        return addressArray.joined(separator: ", ")
    }
}


