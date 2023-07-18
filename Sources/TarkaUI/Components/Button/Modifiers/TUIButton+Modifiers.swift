//
//  TUIButton+Modifiers.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public extension TUIButton {
  
  
  /// Changes its style
  func style(_ style: TUIButton.Style) -> Self {
    var newView = self
    newView.style = style
    return newView
  }
  
  /// Changes its size
  func size(_ size: TUIButton.Size) -> Self {
    var newView = self
    newView.size = size
    return newView
  }
  
  
  /// Accepts the icon and show it in the horizontal stack with title w.r.t to the title
  /// - Parameter icon: An optional `TUIButton.Icon`. It decides the position of icon,
  /// whether is to be in left or right
  /// - Returns: Modified TUIButton
  func icon(_ icon: TUIButton.Icon? = nil) -> Self {
    var newView = self
    newView.icon = icon
    return newView
  }
  
  /// Sets badge in the overlay of the view
  func badge(_ value: String? = nil) -> Self {
    var newView = self
    newView.badge = value
    return newView
  }
  
  /// Sets the width for the button.
  ///
  /// If you pass value, it will be set as width of the button.
  /// If you pass `infinity`, it will pick screen's size width.
  func width(_ value: TUIButton.Width) -> Self {
    var newView = self
    newView.width = value
    return newView
  }
}
