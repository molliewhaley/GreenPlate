//
//  ViewExt.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/9/23.
//

import SwiftUI

extension View {
    func navigationBar(_ title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.customGreen, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func searchBarStyle() -> some View {
        self
            .padding(10)
            .background(Color.white)
            .shadow(radius: 1)
            .cornerRadius(10)
    }
}
