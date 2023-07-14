//
//  View+Extension.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

extension View {
  
  @ViewBuilder
  func isEnabled<Content: View>(_ show: Bool,
                                content: (Self) -> Content) -> some View {
    if show {
      content(self)
    } else {
      self
    }
  }
  
  @ViewBuilder
  func roundedCorner(width: CGFloat, color: Color) -> some View {
    if width > 0 {
      self.overlay(
        RoundedRectangle(cornerRadius: .infinity)
          .stroke(color, lineWidth: width)
      )
      .clipShape(Capsule())
    } else {
      self
        .cornerRadius(.infinity)
        .border(color, width: width)
    }
  }
}
