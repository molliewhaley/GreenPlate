//
//  BackButtonView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/10/23.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .semibold))
        }
    }
}
