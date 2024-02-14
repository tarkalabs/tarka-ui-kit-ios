//
//  TUIIconButton.swift
//
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import SwiftUI

/// A button that displays an icon.
///
/// Use an `IconButton` to display an icon that performs an action when tapped.
///
/// You can customize the appearance of the button by specifying a style. The `outline` style shows a transparent button with an outline around the icon, while the `ghost` style shows a transparent button with no outline. The `secondary` and `primary` styles show a button with a background color that matches the secondary and primary colors of the app, respectively.
///
/// You can also customize the size of the button by specifying a size.
///
/// Example usage:
///
///     TUIIconButton(icon: .plus) {
///         doSomething()
///     }
///     .style(.primary)
///     .size(.size40)
///
/// - Parameters:
///   - icon: The icon to display in the button.
///   - action: The action to perform when the user taps the button.
///
public struct TUIIconButton: View, Identifiable {
  
  public enum Style {
    case outline, ghost, secondary, primary
  }

  public enum Size {
    case size20, size24, size32, size40, size48
  }
  
  public let id = UUID()
  /// The icon to display in the button.
  /// 
  public var icon: FluentIcon
  
  var iconColor: Color?
  var backgroundColor: Color?

  /// The action to perform when the user taps the button.
  public var action: () -> Void

  var style: Style = .ghost
  var size: Size = .size40
  var isDisabled: Bool = false
  
  /// Creates a button that displays an icon.
  ///
  /// - Parameters:
  ///   - icon: The icon to display in the button.
  ///   - action: The action to perform when the user taps the button.
  ///
  public init(icon: FluentIcon, action: @escaping () -> Void) {
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
    .clipShape(Circle())
    .overlay(content: borderView)
    .isDisabled(isDisabled)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var iconView: some View {
    Image(fluent: icon)
      .scaledToFit()
      .frame(
        width: iconSize.width,
        height: iconSize.height
      )
      .clipped()
      .foregroundColor(iconColor ?? defaultIconColor)
      .background(backgroundColor ?? defaultBackgroundColor)
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

extension TUIIconButton {
  
  var defaultIconColor: Color {
    switch style {
    case .outline, .ghost:
      return .onSurface
    case .secondary:
      return .onSecondary
    case .primary:
      return .onPrimary
    }
  }
  
  var defaultBackgroundColor: Color {
    switch style {
    case .outline, .ghost:
      return .clear
    case .secondary:
      return .secondaryTUI
    case .primary:
      return .primaryTUI
    }
  }
  
  var borderColor: Color {
    switch style {
    case .ghost, .secondary, .primary:
      return backgroundColor ?? defaultBackgroundColor
    case .outline:
      return .outline
    }
  }
  
  var buttonSize: CGSize {
    switch size {
    case .size20:
      return CGSize(width: 20, height: 20)
    case .size24:
      return CGSize(width: 24, height: 24)
    case .size32:
      return CGSize(width: 32, height: 32)
    case .size40:
      return CGSize(width: 40, height: 40)
    case .size48:
      return CGSize(width: 48, height: 48)
    }
  }
  
  var iconSize: CGSize {
    switch size {
    case .size20, .size24:
      return CGSize(width: 12, height: 12)
    default:
      return CGSize(width: 24, height: 24)
    }
  }
}

extension TUIIconButton {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIButton"
  }
}

struct IconButtonView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TUIIconButton(
        icon: .chevronRight24Filled) { }
        .iconColor(.white)
        .style(.secondary)
        .size(.size40)
    }
  }
}
