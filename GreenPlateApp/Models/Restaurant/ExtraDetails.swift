//
//  ExtraRestaurantDetails.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/3/23.
//

import Foundation

struct RestaurantHours: Codable {
    let hours: [Hours]
}

struct Hours: Codable {
    let open: [Open]
}

struct Open: Codable {
    let start: String
    let end: String
    let day: Int
}

