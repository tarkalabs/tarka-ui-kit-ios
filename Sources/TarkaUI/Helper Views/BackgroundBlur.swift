//
//  BackgroundBlur.swift
//  
//
//  Created by Gopinath on 11/08/23.
//
import SwiftUI

/// A View in which content reflects all behind it
private struct BackgroundVisualEffectiveView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
      let blur = UIBlurEffect(style: .prominent)
        let animator = UIViewPropertyAnimator()
        animator.addAnimations { view.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(false)
        animator.finishAnimation(at: .current)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}

/// A transparent View that blurs its background
struct BackgroundBlur: View {
    
    let radius: CGFloat
    
    @ViewBuilder
    var body: some View {
        BackgroundVisualEffectiveView().blur(radius: radius)
    }
}
