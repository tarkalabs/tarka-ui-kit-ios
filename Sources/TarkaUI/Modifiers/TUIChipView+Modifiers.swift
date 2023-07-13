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
  ///   - isSelected: This bool used to select the chip view, applicable for onlyTitle and withButton
  ///   - badgeCount: This is used to display the badge view in top trailing only applicable for withButton type
  ///   - action: This block will execute when view interacted
  /// - Returns: A closure that returns the TUIChipView
  func style(filter: Filter, isSelected: Bool = false,
             badgeCount: Int? = nil, action: (() -> Void)? = nil) -> Self {
    var newView = self
    newView.style = Style.filter(filter)
    newView.isSelected = isSelected
    newView.badgeCount = badgeCount
    newView.action = action
    return newView
  }
  
  func size(_ size: Size) -> Self {
    var newView = self
    newView.size = size
    return newView
  }
  
  func styleWithAction(_ style: FilterWithIcon, action: (() -> Void)? = nil) -> Self {
    var newView = self
    newView.style = Style.filterWithIcon(style)
    newView.action = action
    return newView
  }
}
