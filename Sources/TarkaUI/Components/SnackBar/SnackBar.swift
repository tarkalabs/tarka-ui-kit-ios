//
//  SnackBar.swift
//
//
//  Created by Arvindh Sukumar on 22/05/23.
//

import SwiftUI

public enum SnackBarStyle: EnvironmentKey {
  case success, info, warning, error
  public static var defaultValue: SnackBarStyle = .success
  
  var icon: Symbol {
    switch self {
    case .success: return .checkmarkCircle
    case .warning: return .warning
    case .info: return .info
    case .error: return .error
    }
  }
  
  var color: Color {
    switch self {
    case .success:
      return .success
    case .info:
      return .secondaryTUI
    case .warning:
      return .warning
    case .error:
      return .error
    }
  }
  
  var textColor: Color {
    switch self {
    case .success:
      return .onSuccess
    case .info:
      return .onSecondary
    case .warning:
      return .onWarning
    case .error:
      return .onError
    }
  }
}

/// A view that displays a message for a brief period of time and then disappears automatically.
///
/// Use a snackbar to display a brief message at the bottom of the screen. Snackbars appear above all other elements on screen and only one can be displayed at a time.
///
/// Parameters:
/// - message: The message to display in the snackbar.
///
/// Example:
/// ```
/// SnackBar(message: "This is a snackbar")
///  .snackBarStyle(.success)
/// ```
///

public struct SnackBar: View {
  @Environment(\.snackBarStyle) var style
  var message: any StringProtocol
  
  /// Creates a snackbar with the specified message.
  ///
  /// - Parameters:
  ///   - message: The message to display in the snackbar.
  ///
  public init(message: any StringProtocol) {
    self.message = message
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      iconView
      label
    }
    .background(Capsule().foregroundColor(style.color))
  }
  
  @ViewBuilder
  private var iconView: some View {
    Image(style.icon)
      .resizable()
      .scaledToFit()
      .foregroundColor(style.textColor)
      .frame(width: 24, height: 24)
      .padding(.leading, Spacing.baseHorizontal)
      .padding(.trailing, Spacing.halfHorizontal)
  }
  
  @ViewBuilder
  private var label: some View {
    Text(message)
      .font(.body6)
      .foregroundColor(style.textColor)
      .padding(.trailing, Spacing.baseHorizontal)
      .padding(.vertical, Spacing.verticalMultiple(4))
  }
}

struct SnackBar_Previews: PreviewProvider {
  static var previews: some View {
    SnackBar(message: "Test")
      .snackBarStyle(.success)
  }
}
