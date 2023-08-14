//
//  TUIIconButton+Modifiers.swift
//  
//
//  Created by Arvindh Sukumar on 09/05/23.
//

import SwiftUI


public extension TUIIconButton {
  
  /// Sets the `style` for an `TUIIconButton`.
  ///
  /// - Parameter style: The `TUIIconButtonStyle` to use.
  /// - Returns: A modified `TUIIconButton` that has the `style` that overrides the default style.
  func style(_ style: TUIIconButton.Style) -> TUIIconButton {
    var newView = self
    newView.style = style
    return newView
  }
  
  /// Sets the `size` for an `TUIIconButton`.
  ///
  /// - Parameter size: The `TUIIconButtonSize` to use.
  /// - Returns: A modified `TUIIconButton` that has the `size` that overrides the default size.
  func size(_ size: TUIIconButton.Size) -> TUIIconButton {
    var newView = self
    newView.size = size
    return newView
  }
  
  /// Sets the `icon color` for an `TUIIconButton`.
  ///
  /// - Parameter color: The `Icon color` to use.
  /// - Returns: A modified `TUIIconButton` that has the `Icon color` that overrides the default icon color.
  func iconColor(_ color: Color) -> TUIIconButton {
    var newView = self
    newView.iconColor = color
    return newView
  }
  
  /// Sets the `action` for an `TUIIconButton`.
  ///
  /// - Parameter action: The `action` to be called when button is clicked.
  /// - Returns: A modified `TUIIconButton`
  func action(_ action: @escaping () -> Void) -> TUIIconButton {
    var newView = self
    newView.action = action
    return newView
  }
  
  /// Makes `TUIIconButton` disabled.
  ///
  /// - Parameter isDisabled: true / false
  /// - Returns: A modified `TUIIconButton`
  func isDisabled(_ isDisabled: Bool) -> TUIIconButton {
    var newView = self
    newView.isDisabled = isDisabled
    return newView
  }
}
