//
//  Restaurant.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/28/23.
//

import Foundation
import CoreLocation
import SwiftUI

struct Businesses: Codable {
    let businesses: [Restaurants]
}

struct Restaurants: Codable, Identifiable {
    let id: String 
    let categories: [Categories]
    let coordinates: Coordinates
    let displayPhone: String
    let imageUrl: String
    let isClosed: Bool
    let location: Location
    let name: String
    let phone: String
    let price: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categories
        case coordinates
        case displayPhone = "display_phone"
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case location
        case name
        case phone
        case price
        case rating
    }
}

extension Restaurants {
    var unwrappedPrice: String {
        return price ?? ""
    }
    
    var unwrappedRating: Double {
        return rating ?? 0.0
    }
    
    var formattedPrice: Text {
        if unwrappedPrice.count == 1 {
            return Text("$") + Text("$$").foregroundColor(.gray)
        } else if unwrappedPrice.count == 2 {
            return Text("$$") + Text("$").foregroundColor(.gray)
        } else {
            return Text(unwrappedPrice)
        }
    }
    
    var stars: Text {
        var starsText = Text("")
        let flooredRating = Int(floor(unwrappedRating))
        for _ in 0..<flooredRating {
            starsText = starsText + Text(Image(systemName: "star.fill")).foregroundColor(.yellow)
        }
        if ceil(unwrappedRating) > floor(unwrappedRating) {
            starsText = starsText + Text(Image(systemName: "star.leadinghalf.filled")).foregroundColor(.yellow)
        }
        let remainingStars = 5 - Int(ceil(unwrappedRating))
        for _ in 0..<remainingStars {
            starsText = starsText + Text(Image(systemName: "star")).foregroundColor(.gray)
        }
        return starsText
    }
}

struct Categories: Codable, Hashable {
    let title: String
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

extension Coordinates {
    var locationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Location: Codable {
    let displayAddress: [String]
    let city: String
    let country: String
    let state: String
    let zipCode: String
    
    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
        case city
        case country
        case state
        case zipCode = "zip_code"
    }
}

extension Location {
    var address: String {
        return displayAddress.joined(separator: ", ")
    }
}
