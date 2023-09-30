//
//  WalkingBroccoliView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import SwiftUI

struct WalkingBroccoliView: View {
    let loadingText: String
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                LottieView(animationName: "WalkingBroccoli", loop: .loop)
                    .frame(width: 350)
                Text(loadingText)
                    .font(.oswald(size: 20))
            }
            .frame(height: 250)
        }
    }
}
