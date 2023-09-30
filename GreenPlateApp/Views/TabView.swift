//
//  ContentView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/16/23.
//

import SwiftUI
import CoreData

struct TabContentView: View {
    @StateObject private var coreVM = CoreVM()
    
    var body: some View {
        TabView {
            self.searchRecipesTab
            self.cookbookTab
            self.locationTab
            self.barcodeTab
        }
        .accentColor(.white)
    }    
}

extension TabContentView {
    var searchRecipesTab: some View {
        SearchRecipesView(coreVM: coreVM)
            .tabItem {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 50, weight: .medium, design: .serif))
            }
            .toolbarBackground(Color.customGreen, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
    
    private var cookbookTab: some View {
        CookbookView(coreVM: coreVM)
            .environmentObject(coreVM)
            .tabItem {
                Image(systemName: "heart.fill")
            }
            .toolbarBackground(Color.customGreen, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
    
    private var locationTab: some View {
        LocationStatusResultsView()
            .tabItem {
                Image(systemName: "location.fill")
            }
            .toolbarBackground(Color.customGreen, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
    
    private var barcodeTab: some View {
        BarcodeScannerView()
            .tabItem {
                Image(systemName: "barcode.viewfinder")
            }
            .toolbarBackground(Color.customGreen, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
}

