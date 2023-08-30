//
//  View+Layer.swift
//  
//
//  Created by Gopinath on 11/08/23.
//

import SwiftUI

public extension View {
  
  func setRadiusToCorners(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
  
  @ViewBuilder
  /// Sets rounded corner with border
  /// - Parameters:
  ///   - width: border width
  ///   - color: border color
  /// - Returns: View
  func roundedCornerWithBorder(width: CGFloat, color: Color) -> some View {
    self.borderView(Capsule(), width: width, color: color)
  }

  @ViewBuilder
  /// Adds transparent background
  /// - Returns: View
  func transparentBackground() -> some View {
    if #available(iOS 16.4, *) {
      self.presentationBackground(.black.opacity(0.5))
    } else {
      self.background(BackgroundClearView())
    }
  }
  
  /// This method is used to create border View in any swiftUI views
  ///
  /// Example usage:
  ///
  ///      Text("Description")
  ///         .borderView(RoundedRectangle(cornerRadius: Spacing.halfHorizontal), width: 1, color: .gray)
  ///
  @ViewBuilder
  func borderView(_ shape: some Shape,
                  width: CGFloat = 0,
                  color: Color = .clear) -> some View {
    self
      .clipShape(shape)
      .overlay(shape.stroke(color, lineWidth: width))
  }
}
