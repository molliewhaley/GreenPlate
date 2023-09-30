//
//  LocationManager.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/28/23.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    @Published var locationRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    )
    @Published var authorizationStatus: CLAuthorizationStatus?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self

    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.locationRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
        case .notDetermined:
            authorizationStatus = .notDetermined
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            authorizationStatus = .restricted
        case .denied:
            authorizationStatus = .denied
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}
