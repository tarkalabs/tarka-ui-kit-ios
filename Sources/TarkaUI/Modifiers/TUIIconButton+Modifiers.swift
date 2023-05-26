//
//  TUIIconButton+Modifiers.swift
//  
//
//  Created by Arvindh Sukumar on 09/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var iconButtonStyle: TUIIconButtonStyle {
    get { self[TUIIconButtonStyle.self] }
    set { self[TUIIconButtonStyle.self] = newValue }
  }
  
  var iconButtonSize: TUIIconButtonSize {
    get { self[TUIIconButtonSize.self] }
    set { self[TUIIconButtonSize.self] = newValue }
  }
}

public extension View {
  /// Sets the `iconButtonStyle` for an `TUIIconButton`.
  ///
  /// - Parameter style: The `TUIIconButtonStyle` to use.
  /// - Returns: A modified `View` that has the `iconButtonStyle` set as an environment value.
  func iconButtonStyle(_ style: TUIIconButtonStyle) -> some View {
      self.environment(\.iconButtonStyle, style)
  }

  /// Sets the `iconButtonSize` for an `TUIIconButton`.
  ///
  /// - Parameter size: The `TUIIconButtonSize` to use.
  /// - Returns: A modified `View` that has the `iconButtonSize` set as an environment value.
  func iconButtonSize(_ size: TUIIconButtonSize) -> some View {
      self.environment(\.iconButtonSize, size)
  }
}
