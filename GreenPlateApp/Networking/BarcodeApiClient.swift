//
//  BarcodeApiClient.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/18/23.
//

import Foundation

final class BarcodeApiClient {
    
    func fetchFoodFacts(withBarcode barcode: String) async throws -> Product? {
        let urlString = "https://world.openfoodfacts.org/api/v2/search?code=\(barcode)&fields=image_front_url,ingredients_analysis_tags,ingredients_analysis,brands"
        guard let url = URL(string: urlString) else {
            throw ApiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(BarcodeResultData.self, from: data)
            if data.products.isEmpty {
                throw ApiError.itemNotFound
            }
            return data.products.first
            
        } catch {
            throw ApiError.invalidData
        }
    }
}
