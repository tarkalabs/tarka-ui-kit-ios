//
//  TUIChip+Modifiers.swift
//  
//
//  Created by MAHESHWARAN on 13/07/23.
//

import SwiftUI

public extension TUIChip {
  
  /// The style used to display the title with given style options
  /// - Parameters:
  ///   - style: Style can be assist, input, suggestion, Filter
  ///   - size: size32, size40
  /// - Returns: A closure that returns the TUIChip
  func style(_ style: Style, size: Size = .size40) -> Self {
    var newView = self
    newView.inputItem.style = style
    newView.inputItem.size = size
    return newView
  }
  
  /// Filter Style used to display chip options with title and button or icon
  /// - Parameters:
  ///   - filter: Choose the list of options to display view
  ///   - badgeCount: This is used to display the badge view in top trailing only applicable for withButton type
  ///
  /// - Returns: A closure that returns the TUIChip
  func style(filter: Filter, isSelected: Bool = false, badgeCount: Int? = nil, badgeColor: Color = .error) -> Self {
    var newView = self
    newView.inputItem.style = Style.filter(filter)
    newView.inputItem.isSelected = isSelected
    newView.inputItem.badgeCount = badgeCount
    newView.inputItem.badgeColor = badgeColor
    return newView
  }
  
  func action(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.inputItem.action = action
    return newView
  }
  
  func isSelected(_ selected: Bool = false) -> Self {
    var newView = self
    newView.inputItem.isSelected = selected
    return newView
  }
  
  func textColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.textColor = color
    return newView
  }
  
  func textSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.textSelectionColor = color
    return newView
  }
  
  func size(_ size: Size) -> Self {
    var newView = self
    newView.inputItem.size = size
    return newView
  }
  
  func backgroundColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.color = color
    return newView
  }
  
  func backgroundSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.selectionColor = color
    return newView
  }
  
  func foregroundColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.foregroundColor = color
    return newView
  }
  
  func foregroundSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.foregroundSelectionColor = color
    return newView
  }
  
  func borderColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.borderColor = color
    return newView
  }
  
  func cornerRadius(_ radius: CGFloat) -> Self {
    var newView = self
    newView.inputItem.cornerRadius = radius
    return newView
  }
  
  func borderSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.borderSelectionColor = color
    return newView
  }
}
