//
//  ErrorEnum.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/18/23.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidSearch
    case itemNotFound
}
