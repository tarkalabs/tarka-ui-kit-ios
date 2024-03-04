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
    if #available(iOS 16.4, *) {
      self.presentationBackground(.black.opacity(0.5))
    } else {
      self.background(BackgroundColorView(color: .black.opacity(0.5)))
    }
  }
  
  @ViewBuilder
  /// Adds transparent background
  /// - Returns: View
  func transparentBackground() -> some View {
    if #available(iOS 16.4, *) {
      self.presentationBackground(.clear)
    } else {
      self.background(BackgroundColorView(color: .clear))
    }
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
      
      if #available(iOS 16.4, *) {
        self
          .presentationBackground {
            color
              .contentShape(Rectangle())
              .onTapGesture {
                isClicked?()
              }
          }
      } else {
        self.background(
          BackgroundColorView(color: color)
            .contentShape(Rectangle())
            .onTapGesture {
              isClicked?()
            }
        )
      }
    }
}
