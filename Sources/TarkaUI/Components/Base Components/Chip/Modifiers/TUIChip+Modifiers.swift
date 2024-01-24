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
  func style(_ style: ChipStyle, size: Size = .size40) -> Self {
    var newView = self
    newView.style.chipStyle = style
    newView.style.size = size
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
    newView.style.chipStyle = ChipStyle.filter(filter)
    newView.style.isSelected = isSelected
    newView.style.badgeCount = badgeCount
    newView.style.badgeColor = badgeColor
    return newView
  }
  
  func action(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.style.action = action
    return newView
  }
  
  func isSelected(_ selected: Bool = false) -> Self {
    var newView = self
    newView.style.isSelected = selected
    return newView
  }
  
  func textColor(_ color: Color) -> Self {
    var newView = self
    newView.style.textColor = color
    return newView
  }
  
  func textSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.style.textSelectionColor = color
    return newView
  }
  
  func size(_ size: Size) -> Self {
    var newView = self
    newView.style.size = size
    return newView
  }
  
  func backgroundColor(_ color: Color) -> Self {
    var newView = self
    newView.style.color = color
    return newView
  }
  
  func backgroundSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.style.selectionColor = color
    return newView
  }
  
  func foregroundColor(_ color: Color) -> Self {
    var newView = self
    newView.style.foregroundColor = color
    return newView
  }
  
  func foregroundSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.style.foregroundSelectionColor = color
    return newView
  }
  
  func borderColor(_ color: Color) -> Self {
    var newView = self
    newView.style.borderColor = color
    return newView
  }
  
  func borderSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.style.borderSelectionColor = color
    return newView
  }
}
