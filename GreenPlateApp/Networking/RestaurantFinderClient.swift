//
//  RestaurantFinderClient.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/27/23.
//

import Foundation
import CoreLocation

final class RestaurantApiClient {
    private let apiKey = ""
    
    func getRestaurants(fromUrl urlString: String) async throws -> [Restaurants]? {
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]

        guard let url = URL(string: urlString) else {
            print("error is coming from api url")
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            let restaurantData = try decoder.decode(Businesses.self, from: data)
            if !restaurantData.businesses.isEmpty {
                return restaurantData.businesses
            }
            return nil
        } catch {
            throw ApiError.invalidData
        }
    }
}
