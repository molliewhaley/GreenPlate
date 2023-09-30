//
//  BarcodeVM.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/18/23.
//

import Foundation
import SwiftUI
import AVFoundation

@MainActor final class BarcodeVM: ObservableObject {
    @Published var product: Product?
    @Published var errorMessage = ""
    @Published var presentError = false
    @Published var cameraAccess = false
    @Published var showLoading = false
    @Published var goToResults = false
    private let apiClient = BarcodeApiClient()

    var nonVegan: [String] {
        return product?.ingredientsAnalysis["en:non-vegan"]?.map { ingredient in
            ingredient.replacingOccurrences(of: "en:", with: "")
        } ?? []
    }
    
    var veganStatus: Bool {
        return product?.ingredientAnalysisTags.contains("en:vegan") == true
    }
    
    func fetchFoodFacts(fromBarcode barcode: String) async {
        do {
            let data = try await apiClient.fetchFoodFacts(withBarcode: barcode)
            self.product = data 
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showLoading = false
                self.goToResults = true
            }
        } catch ApiError.invalidURL {
            self.showLoading = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.presentError = true
                self.errorMessage = "Unresolved issue. We're working on fixing it."
            }
        } catch ApiError.invalidResponse {
            self.showLoading = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.presentError = true
                self.errorMessage = "Server error. Try again later."
            }
        } catch ApiError.invalidData {
            self.showLoading = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.presentError = true
                self.errorMessage = "Unable to fetch data. Try again later."
            }
        } catch ApiError.itemNotFound {
            self.showLoading = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.presentError = true
                self.errorMessage = "Item not found."
            }
        } catch {
            self.showLoading = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.presentError = true
                self.errorMessage = "Unexpected problem. Try again."
            }
        }
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.cameraAccess = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { choice in
                DispatchQueue.main.async {
                    self.cameraAccess = choice
                }
            }
        default:
            self.cameraAccess = false
        }
    }
}
