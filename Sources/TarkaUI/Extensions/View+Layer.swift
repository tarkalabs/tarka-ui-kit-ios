//
//  View+Layer.swift
//
//
//  Created by Gopinath on 11/08/23.
//

import SwiftUI

public extension View {
  
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
      self.background(BackgroundColorView(color: .black.opacity(0.5)))
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
  
  /// Draws border in specified edges
  /// - Parameters:
  ///   - width: border width
  ///   - edges: edges that require to be drawn
  ///   - color: border color
  /// - Returns: Border drawn view
  func border(
    width: CGFloat, edges: [Edge],
    color: Color) -> some View {
      
      overlay(
        EdgeBorder(width: width, edges: edges)
          .foregroundColor(color))
    }
}
