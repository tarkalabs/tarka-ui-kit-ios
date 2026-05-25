//
//  View+Layer.swift
//
//
//  Created by Gopinath on 11/08/23.
//

import SwiftUI

public extension View {
  
  @ViewBuilder
  /// Adds black overlay background
  /// - Returns: View
  func blackOverlayBackground() -> some View {
    self.presentationBackground(.black.opacity(0.5))
  }

  @ViewBuilder
  /// Adds transparent background
  /// - Returns: View
  func transparentBackground() -> some View {
    self.presentationBackground(.clear)
  }

  @ViewBuilder
  /// Adds background view with color
  /// - Parameters:
  ///   - color: background color
  ///   - isClicked: sends callback when click action happened on this background view
  /// - Returns: View
  func backgroundView(
    withColor color: Color,
    isClicked: (() -> Void)? = nil) -> some View {
      self
        .presentationBackground {
          color
            .contentShape(Rectangle())
            .onTapGesture {
              isClicked?()
            }
        }
    }
}
