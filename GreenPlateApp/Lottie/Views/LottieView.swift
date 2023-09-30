//
//  LottieView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/17/23.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animationName: String
    var loop: LottieLoopMode
    var animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(animationName)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loop
        animationView.play()
        
            view.addSubview(animationView)
            animationView.translatesAutoresizingMaskIntoConstraints = false
             
            NSLayoutConstraint.activate([
              animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
              animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}

extension LottieView {
    func sized(width: CGFloat, height: CGFloat) -> some View {
        self
            .frame(width: width, height: height)
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(animationName: "WalkingBroccoli", loop: .loop)
            .frame(width: 300, height: 300)
    }
}
