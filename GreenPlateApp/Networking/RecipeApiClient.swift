//
//  ApiClient.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/16/23.
//

import Foundation

final class RecipeApiClient {
    private let apiKey = ""
    
    func searchRecipes(withDescription description: String) async throws -> ApiRecipes {
       let urlString =  "https://api.spoonacular.com/recipes/complexSearch?query=\(description)&diet=vegan&instructionsRequired=true&addRecipeInformation=true&addRecipeNutrition=true&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw ApiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ApiRecipes.self, from: data)
            if decodedData.results.isEmpty {
                throw ApiError.invalidSearch
            }
            return decodedData
            
        } catch {
            throw ApiError.invalidData
        }
        
    }
}

