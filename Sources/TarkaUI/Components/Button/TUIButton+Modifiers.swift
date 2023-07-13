//
//  TUIButton+Modifiers.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public extension TUIButton {
  
  func style(_ style: TUIButtonStyle) -> Self {
    var newView = self
    newView.style = style
    return newView
  }
  
  func size(_ size: TUIButtonSize) -> Self {
    var newView = self
    newView.size = size
    return newView
  }
  
  func icon(_ icon: TUIButton.Icon? = nil) -> Self {
    var newView = self
    newView.icon = icon
    return newView
  }
  
  func badge(_ value: String? = nil) -> Self {
    var newView = self
    newView.badge = value
    return newView
  }
  
  func width(_ value: CGFloat? = nil) -> Self {
    var newView = self
    newView.width = value
    return newView
  }
}
