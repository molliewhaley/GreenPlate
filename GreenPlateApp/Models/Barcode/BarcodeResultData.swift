//
//  VeganProduct.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/18/23.
//

import Foundation

struct BarcodeResultData: Codable {
    let products: [Product] 
}

struct Product: Codable {
    let imageFrontUrl: URL
    let ingredientsAnalysis: [String: [String]]
    let ingredientAnalysisTags: [String]
    let brands: String
    
    
    enum CodingKeys: String, CodingKey {
        case imageFrontUrl = "image_front_url"
        case ingredientsAnalysis = "ingredients_analysis"
        case ingredientAnalysisTags = "ingredients_analysis_tags"
        case brands = "brands"
    }
}

