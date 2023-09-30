//
//  ResultsView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/18/23.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var barcodeVM: BarcodeVM
    @Binding var presentProductView: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    self.title
                    self.image
                    self.isVegan
                    self.nonVeganIngredients
                }
            }
            .padding(.top)
            .scrollIndicators(.never)
            .navigationBar("GreenPlate")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    dismissPopover()
                }
            }
        }
    }
}

extension ProductDetailView {
    private var title: some View {
        Text(
            barcodeVM.product?.brands ?? "Untitled"
        )
        .font(.oswaldBold(size: 28))
    }
    private var image: some View {
        ProductImageView(
            productURL: barcodeVM.product?.imageFrontUrl.absoluteString ?? ""
        )
    }
    
    private var isVegan: some View {
        Text(barcodeVM.veganStatus ? "This item is vegan." : "This item is not vegan.")
            .font(.oswald(size: 20))
    }
    
    private var nonVeganIngredients: some View {
        VStack(spacing: 10) {
            if !(barcodeVM.nonVegan.isEmpty) {
                Text("Non-vegan ingredients:")
                    .font(.oswaldBold(size: 22))
                    .padding(.bottom, 8)
                
                ForEach(barcodeVM.nonVegan, id: \.self) { ingredient in
                    Text("- \(ingredient)")
                        .font(.oswald(size: 20))
                        .padding(.horizontal)
                }
            }
        }
    }
}

extension ProductDetailView {
    private func dismissPopover() -> some View {
        Button {
            barcodeVM.goToResults = false
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .semibold))
        }
    }
}

