//
//  IconButton+Modifiers.swift
//  
//
//  Created by Arvindh Sukumar on 09/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var iconButtonStyle: IconButtonStyle {
    get { self[IconButtonStyle.self] }
    set { self[IconButtonStyle.self] = newValue }
  }
  
  var iconButtonSize: IconButtonSize {
    get { self[IconButtonSize.self] }
    set { self[IconButtonSize.self] = newValue }
  }
}

public extension View {
  /// Sets the `iconButtonStyle` for an `IconButton`.
  ///
  /// - Parameter style: The `IconButtonStyle` to use.
  /// - Returns: A modified `View` that has the `iconButtonStyle` set as an environment value.
  func iconButtonStyle(_ style: IconButtonStyle) -> some View {
      self.environment(\.iconButtonStyle, style)
  }

  /// Sets the `iconButtonSize` for an `IconButton`.
  ///
  /// - Parameter size: The `IconButtonSize` to use.
  /// - Returns: A modified `View` that has the `iconButtonSize` set as an environment value.
  func iconButtonSize(_ size: IconButtonSize) -> some View {
      self.environment(\.iconButtonSize, size)
  }
}
