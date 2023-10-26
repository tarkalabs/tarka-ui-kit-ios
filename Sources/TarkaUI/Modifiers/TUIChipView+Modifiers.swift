//
//  TUIChipView+Modifiers.swift
//  
//
//  Created by MAHESHWARAN on 13/07/23.
//

import SwiftUI

public extension TUIChipView {
  
  /// The style used to display the title with given style options
  /// - Parameters:
  ///   - style: Style can be assist, input, suggestion, Filter
  ///   - size: size32, size40
  /// - Returns: A closure that returns the TUIChipView
  func style(_ style: Style, size: Size = .size40) -> Self {
    var newView = self
    newView.style = style
    newView.size = size
    return newView
  }
  
  /// Filter Style used to display chip options with title and button or icon
  /// - Parameters:
  ///   - filter: Choose the list of options to display view
  ///   - badgeCount: This is used to display the badge view in top trailing only applicable for withButton type
  ///
  /// - Returns: A closure that returns the TUIChipView
  func style(filter: Filter, isSelected: Bool = false, badgeCount: Int? = nil) -> Self {
    var newView = self
    newView.style = Style.filter(filter)
    newView.isSelected = isSelected
    newView.badgeCount = badgeCount
    return newView
  }
  
  func action(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.action = action
    return newView
  }
  
  func isSelected(_ selected: Bool = false) -> Self {
    var newView = self
    newView.isSelected = selected
    return newView
  }
  
  func textColor(_ color: Color = .onSurface) -> Self {
    var newView = self
    newView.textColor = color
    return newView
  }
  
  func size(_ size: Size) -> Self {
    var newView = self
    newView.size = size
    return newView
  }
  
  func backgroundColor(_ color: Color) -> Self {
    var newView = self
    newView.backgroundColor = color
    return newView
  }
  
  func borderColor(_ color: Color) -> Self {
    var newView = self
    newView.borderColor = color
    return newView
  }
}
