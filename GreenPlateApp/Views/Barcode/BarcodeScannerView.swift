//
//  BarcodeScannerView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import SwiftUI
import CodeScanner
import AVFoundation

struct BarcodeScannerView: View {
    @ObservedObject private var barcodeVM = BarcodeVM()
    private let apiClient = BarcodeApiClient()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if barcodeVM.cameraAccess {
                    self.codeScanner
                } else {
                    self.emptyView
                }
            }
            .fullScreenCover(isPresented: $barcodeVM.showLoading, content: {
                WalkingBroccoliView(loadingText: "Strolling through barcode wonderland.")
            })
            .fullScreenCover(isPresented: $barcodeVM.goToResults, content: {
                self.productDetail
            })
            
            .alert(isPresented: $barcodeVM.presentError) {
                Alert(
                    title: Text("Error"),
                    message: Text(barcodeVM.errorMessage),
                    dismissButton: .default(Text("Ok")) {
                        barcodeVM.presentError = false
                        barcodeVM.errorMessage = ""
                    })
            }
            .navigationBar("GreenPlate")
            .onAppear {
                barcodeVM.checkCameraAccess()
            }
        }
    }
}

extension BarcodeScannerView {
    private var emptyView: some View {
        EmptyContentView(
            message: "Enable camera to use barcode scanner.",
            image: "barcode.viewfinder"
        )
    }
    
    private var codeScanner: some View {
        CodeScannerView(codeTypes: [.ean8, .ean13, .pdf417, .code128, .code39, .code93], scanMode: .oncePerCode, showViewfinder: true) { response in
            if case let .success(result) = response {
                Task {
                    barcodeVM.showLoading = true
                    await barcodeVM.fetchFoodFacts(fromBarcode: result.string)
                }
            } else {
                barcodeVM.presentError = true
                barcodeVM.errorMessage = "Error scanning."
            }
        }
    }
    
    private var productDetail: some View {
        ProductDetailView(
            barcodeVM: barcodeVM, presentProductView: $barcodeVM.goToResults
        )
    }
}


