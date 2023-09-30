//
//  EmptyView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import SwiftUI

struct EmptyContentView: View {
    let message: String
    let image: String
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.system(size: 75))
                .padding()
            
            Text(message)
                .padding(.horizontal)
                .font(.oswald(size: 20))
                .multilineTextAlignment(.center)
        }
        .foregroundColor(Color.customGreen)
    }
}

