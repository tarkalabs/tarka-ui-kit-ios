//
//  View+Border.swift
//
//
//  Created by MAHESHWARAN on 24/01/24.
//

import SwiftUI

public extension View {
  
  /// This method is used to create border View in any swiftUI views
  ///
  /// Example usage:
  ///
  ///      Text("Description")
  ///         .border(RoundedRectangle(cornerRadius: Spacing.halfHorizontal), width: 1, color: .gray)
  ///
  ///
  ///
  @ViewBuilder
  func border(_ shape: some Shape, width: CGFloat = 0, color: Color = .clear, isEnabled: Bool = true) -> some View {
    self
      .clipShape(shape)
      .isEnabled(isEnabled) {
        $0.overlay(shape.stroke(color, lineWidth: width))
      }
  }
}
