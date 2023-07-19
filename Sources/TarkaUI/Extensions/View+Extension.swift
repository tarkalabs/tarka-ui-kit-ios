//
//  View+Extension.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

extension View {
  
  @ViewBuilder
  func roundedCorner(width: CGFloat, color: Color) -> some View {
    if width > 0 {
      self.overlay(
        Capsule()
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
