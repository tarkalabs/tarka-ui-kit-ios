//
//  File.swift
//  
//
//  Created by Arvindh Sukumar on 22/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var snackBarStyle: TUISnackBarStyle {
    get { self[TUISnackBarStyle.self] }
    set { self[TUISnackBarStyle.self] = newValue }
  }
}

public extension View {
  /// Sets the `snackBarStyle` for `SnackBars`
  ///
  /// - Parameter style: The `TUISnackBarStyle` to use.
  /// - Returns: A modified `View` that has the `snackBarStyle` set as an environment value.
  func snackBarStyle(_ style: TUISnackBarStyle) -> some View {
    self.environment(\.snackBarStyle, style)
  }
}
