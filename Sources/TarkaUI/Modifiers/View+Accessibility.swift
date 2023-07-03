//
//  View+Accessibility.swift
//  
//
//  Created by Arvindh Sukumar on 02/06/23.
//

import SwiftUI

public extension View {
  func accessibilityIdentifier(_ accessibility: TUIAccessibility) -> some View {
    self
      .accessibilityIdentifier(accessibility.identifier)
  }
  
  /// List Row Insets used to create a new view based on the padding amount
  /// - Parameters:
  ///   - vertical: vertical padding amount
  ///   - horizontal: horizontal padding amount
  /// - Returns: A view that's padded by the amount you specify.
  /// 
  func listRowInsets(_ vertical: CGFloat, _ horizontal: CGFloat) -> some View {
    self.listRowInsets(EdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal))
  }
}
