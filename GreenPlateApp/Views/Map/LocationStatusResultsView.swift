//
//  RestaurantFinderView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/26/23.
//

import SwiftUI
import MapKit

struct LocationStatusResultsView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            LayeredMapView(locationManager: locationManager)
        case .notDetermined:
            WalkingBroccoliView(loadingText: "Broccoli's on the move: searching for nearby restaurants.")
        case .restricted, .denied:
            EmptyContentView(message: "Looking for new restaurants? Enable location access in settings.", image: "location.fill")
        default:
            EmptyContentView(message: "", image: "location.fill")
        }
    }
}



