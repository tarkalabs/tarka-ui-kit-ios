//
//  IconButton.swift
//
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import SwiftUI

public enum IconButtonStyle: EnvironmentKey {
  case outline, ghost, secondary, primary
  public static let defaultValue: IconButtonStyle = .ghost
}

public enum IconButtonSize: EnvironmentKey {
  case xs, s, m, l, xl
  public static let defaultValue: IconButtonSize = .l
}

public struct IconButton: View {
  public var icon: EAMSymbol
  public var action: () -> Void

  @Environment(\.iconButtonStyle) var style
  @Environment(\.iconButtonSize) var size
  
  public init(icon: EAMSymbol, action: @escaping () -> Void) {
    self.icon = icon
    self.action = action
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      iconView
    }
    .frame(
      width: buttonSize.width,
      height: buttonSize.height
    )
    .background(backgroundView)
    .contentShape(Circle()) // So that only the circular portion is tappable
    .clipShape(Circle())
    .overlay(content: borderView)
  }
  
  @ViewBuilder
  private var iconView: some View {
    Image(icon)
      .resizable()
      .scaledToFit()
      .frame(
        width: iconSize.width,
        height: iconSize.height
      )
      .foregroundColor(iconColor)
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity
      ) // So that the entire button is tappable, not just the icon
  }
  
  @ViewBuilder
  private var backgroundView: some View {
    backgroundColor
  }
  
  @ViewBuilder
  private func borderView() -> some View {
    Circle()
      .stroke(
        borderColor,
        style: StrokeStyle(
          lineWidth: 1.5
        )
      )
  }
}

extension IconButton {
  var iconColor: Color {
    switch style {
    case .outline, .ghost:
      return .onSurface
    case .secondary:
      return .onSecondary
    case .primary:
      return .onPrimary
    }
  }
  
  var backgroundColor: Color {
    switch style {
    case .outline, .ghost:
      return .clear
    case .secondary:
      return .secondaryEAM
    case .primary:
      return .primaryEAM
    }
  }
  
  var borderColor: Color {
    switch style {
    case .ghost, .secondary, .primary:
      return backgroundColor
    case .outline:
      return .outline
    }
  }
  
  var buttonSize: CGSize {
    switch size {
    case .xs:
      return CGSize(width: 20, height: 20)
    case .s:
      return CGSize(width: 24, height: 24)
    case .m:
      return CGSize(width: 32, height: 32)
    case .l:
      return CGSize(width: 40, height: 40)
    case .xl:
      return CGSize(width: 48, height: 48)
    }
  }
  
  var iconSize: CGSize {
    switch size {
    case .xs, .s:
      return CGSize(width: 12, height: 12)
    case .m, .l, .xl:
      return CGSize(width: 24, height: 24)
    }
  }
}

struct IconButtonView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      IconButton(
        icon: .chevronDown,
        action: {
        
      })
      .iconButtonStyle(.secondary)
      .iconButtonSize(.m)
    }
  }
}
