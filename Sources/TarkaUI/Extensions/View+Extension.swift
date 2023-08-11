//
//  View+Extension.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI



public extension View {
  
  /// Adds done button in toolbar
  /// - Parameter onClicked: closure that called when done button is clicked
  /// - Returns: View
  ///
  @ViewBuilder
  func addDoneButtonInToolbar(
    isDoneClicked: Binding<Bool>,
    onClicked: (() -> Void)? = nil) -> some View {
    modifier(ToolBarDoneButton(isDoneClicked: isDoneClicked))
  }
  
  @ViewBuilder
  func transparentBackground() -> some View {
    if #available(iOS 16.4, *) {
      self.presentationBackground(.black.opacity(0.5))
    } else {
      self.background(BackgroundClearView())
    }
  }
  
  @ViewBuilder
  func roundedCornerWithBorder(width: CGFloat, color: Color) -> some View {
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
