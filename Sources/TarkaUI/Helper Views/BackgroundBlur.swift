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
    view.alpha = 0.9
    let blur = UIBlurEffect(style: .regular)
    view.effect = blur
    return view
  }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}

/// A transparent View that blurs its background
public struct BackgroundBlur: View {
  
  public init() { }
  
  @ViewBuilder
  public var body: some View {
    BackgroundVisualEffectiveView()
  }
}
