//
//  BackgroundBlur.swift
//  
//
//  Created by Gopinath on 11/08/23.
//
import SwiftUI

/// A View in which content reflects all behind it
struct BackgroundVisualEffectView: UIViewRepresentable {

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
    BackgroundVisualEffectView()
  }
}


/// A transparent View that blurs its background
public struct BackgroundBlurView: ViewModifier {
  
  var color: Color
  var opacity: Double
  
  @State var width: CGFloat = 0
  @State var height: CGFloat = 0

  public init(color: Color, opacity: Double) {
    self.color = color
    self.opacity = opacity
  }
  
  public func body(content: Content) -> some View {
    ZStack {
      color.opacity(opacity/100)
        .frame(width: width, height: height)
      content
        .background(BackgroundVisualEffectView())
        .background(Color.clear)
        .getWidth($width)
        .getHeight($height)
    }
  }
}
