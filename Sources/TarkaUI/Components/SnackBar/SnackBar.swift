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

public struct SnackBar: View {
  @Environment(\.snackBarStyle) var style
  var message: any StringProtocol
  
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
