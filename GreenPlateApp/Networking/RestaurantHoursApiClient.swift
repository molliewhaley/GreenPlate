//
//  RestaurantHoursApiClient.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/3/23.
//

import Foundation

final class RestaurantHoursApiClient {
    private let apiKey = ""
    
    func getHours(restaurantId id: String) async throws -> [Hours]? {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        let urlString = "https://api.yelp.com/v3/businesses/\(id)"
        
        guard let url = URL(string: urlString) else {
            print("debug - url is invalid")
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(response)
                throw ApiError.invalidResponse
            }
            
            let decodeder = JSONDecoder()
            let hourData = try decodeder.decode(RestaurantHours.self, from: data)
            
            if !hourData.hours.isEmpty {
                return hourData.hours
            }
            return nil 
            
        } catch {
            throw ApiError.invalidData
        }
    }
}
