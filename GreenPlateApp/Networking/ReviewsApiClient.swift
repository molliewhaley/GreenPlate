//
//  ReviewsApiClient.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/2/23.
//

import Foundation

final class ReviewsApiClient {
    private let apiKey = ""
    
    func getReviews(restaurantId id: String) async throws -> [ReviewDetails]? {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        let urlString = "https://api.yelp.com/v3/businesses/\(id)/reviews?limit=5&sort_by=yelp_sort"
        
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
            
            let decoder = JSONDecoder()
            let reviewData = try decoder.decode(Reviews.self, from: data)
            
            if !reviewData.reviews.isEmpty {
                return reviewData.reviews
            }
            return nil
            
        } catch {
            print(error)
            throw ApiError.invalidData
        }
        
    }
}
