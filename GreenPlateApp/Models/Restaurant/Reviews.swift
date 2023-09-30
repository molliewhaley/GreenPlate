//
//  Reviews.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/3/23.
//
import Foundation
import SwiftUI

struct Reviews: Codable {
    let reviews: [ReviewDetails]
}

struct ReviewDetails: Codable, Identifiable {
    let id: String
    let url: String 
    let text: String
    let rating: Int
    let user: UserDetails
}

extension ReviewDetails {
    var reviewStars: Text {
        var starsText = Text("")
        let flooredRating = Int(floor(Double(rating)))
        for _ in 0..<flooredRating {
            starsText = starsText + Text(Image(systemName: "star.fill")).foregroundColor(.yellow)
        }
        if ceil(Double(rating)) > floor(Double(rating)) {
            starsText = starsText + Text(Image(systemName: "star.leadinghalf.filled")).foregroundColor(.yellow)
        }
        let remainingStars = 5 - Int(ceil(Double(rating)))
        for _ in 0..<remainingStars {
            starsText = starsText + Text(Image(systemName: "star")).foregroundColor(.gray)
        }
        return starsText
    }
}

struct UserDetails: Codable {
    let imageUrl: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case name
    }
}

extension UserDetails {
    var unwrappedImageUrl: String {
        return imageUrl ?? ""
    }
}
