//
//  CircularProgressView.swift
//
//
//  Created by Arvindh Sukumar on 01/05/23.
//

import SwiftUI

public struct CircularProgressView<Label: View>: View {
  public var progress: Double = 0.0
  public let label: () -> Label
  
  private let lineWidth: CGFloat = 4
  
  public init(progress: Double, @ViewBuilder labelView: @escaping () -> Label) {
    self.progress = progress
    self.label = labelView
  }
  
  public var body: some View {
    GeometryReader { proxy in
      ZStack {
        backgroundCircleView
        progressCircleView
        labelView(proxy)
      }
    }
  }
  
  @ViewBuilder
  private var backgroundCircleView: some View {
    Circle()
      .stroke(
        Color.surfaceHover,
        lineWidth: lineWidth
      )
  }
  
  @ViewBuilder
  private var progressCircleView: some View {
    Circle()
      .trim(from: 0, to: progress)
      .stroke(
        Color.primaryEAM,
        style: StrokeStyle(
          lineWidth: lineWidth
        )
      )
      .rotationEffect(.degrees(-90)) // Rotate by 90 degrees, otherwise the progress starts at the right side instead of at the top of the circle
      .animation(.easeOut, value: progress)
  }
  
  @ViewBuilder
  private func labelView(_ proxy: GeometryProxy) -> some View {
    label()
      .padding(proxy.size.width * 0.2)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct CircularProgressView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CircularProgressView(progress: 0.4) {
        Image(.checkmarkStarburst)
          .resizable()
          .scaledToFit()

      }
      .frame(width: 40, height: 40)
      
      CircularProgressView(progress: 0.4) {
        Image(.checkmarkStarburst)
          .resizable()
          .scaledToFit()

      }
      .frame(width: 100, height: 100)
    }
  }
}
