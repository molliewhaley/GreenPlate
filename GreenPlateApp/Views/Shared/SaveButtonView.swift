//
//  SaveButtonView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/22/23.
//

import SwiftUI

struct SaveButtonView: View {
    @Binding var isSaved: Bool
    let handleSave: () -> Void
    
    var body: some View {
        Button {
            self.handleSave()
        } label: {
            Image(systemName: self.isSaved ? "heart.fill" : "heart")
                .font(.system(size: 18))
                .foregroundColor(.white)
        }
    }
}

