//
//  SearchBarView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/9/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    let searchDescription: String 
    let handleSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search new \(searchDescription)", text: $searchText)
                .textFieldStyle(.plain)
            Button {
                self.handleSearch()
            } label: {
                Image(systemName: "magnifyingglass")
                    .searchImage()
            }
        }
        .searchBarStyle()
    }
}



