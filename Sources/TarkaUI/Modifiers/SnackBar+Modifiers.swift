//
//  File.swift
//  
//
//  Created by Arvindh Sukumar on 22/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var snackBarStyle: SnackBarStyle {
    get { self[SnackBarStyle.self] }
    set { self[SnackBarStyle.self] = newValue }
  }
}

public extension View {
  /// Sets the `snackBarStyle` for `SnackBars`
  ///
  /// - Parameter style: The `SnackBarStyle` to use.
  /// - Returns: A modified `View` that has the `snackBarStyle` set as an environment value.
  func snackBarStyle(_ style: SnackBarStyle) -> some View {
    self.environment(\.snackBarStyle, style)
  }
}
