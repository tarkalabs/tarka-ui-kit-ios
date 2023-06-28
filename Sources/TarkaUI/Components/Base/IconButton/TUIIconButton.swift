//
//  TUIIconButton.swift
//
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import SwiftUI


public enum TUIIconButtonStyle: EnvironmentKey {
  case outline, ghost, secondary, primary
  public static let defaultValue: TUIIconButtonStyle = .ghost
}

public enum TUIIconButtonSize: EnvironmentKey {
  case xs, s, m, l, xl
  public static let defaultValue: TUIIconButtonSize = .l
}

/// A button that displays an icon.
///
/// Use an `IconButton` to display an icon that performs an action when tapped.
///
/// You can customize the appearance of the button by specifying a style. The `outline` style shows a transparent button with an outline around the icon, while the `ghost` style shows a transparent button with no outline. The `secondary` and `primary` styles show a button with a background color that matches the secondary and primary colors of the app, respectively.
///
/// You can also customize the size of the button by specifying a size. The `xs`, `s`, `m`, `l`, and `xl` sizes correspond to 20, 24, 32, 40, and 48 points, respectively.
///
/// Example usage:
///
///     TUIIconButton(icon: .plus) {
///         doSomething()
///     }
///     .iconButtonStyle(.primary)
///     .iconButtonSize(.xl)
///
/// - Parameters:
///   - icon: The icon to display in the button.
///   - action: The action to perform when the user taps the button.
///
public struct TUIIconButton: View, Identifiable {
  
  public let id = UUID()
  /// The icon to display in the button.
  /// 
  public var icon: Icon
  
  var iconColor: Color?

  /// The action to perform when the user taps the button.
  public var action: () -> Void

  var style: TUIIconButtonStyle = .ghost
  var size: TUIIconButtonSize = .l
  
  /// Creates a button that displays an icon.
  ///
  /// - Parameters:
  ///   - icon: The icon to display in the button.
  ///   - action: The action to perform when the user taps the button.
  ///
  public init(icon: Icon, action: @escaping () -> Void) {
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
    .accessibilityIdentifier(Accessibility.root)
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
      .foregroundColor(iconColor ?? defaultIconColor)
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
  
  var backgroundColor: Color {
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

extension TUIIconButton {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIButton"
  }
}

struct IconButtonView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TUIIconButton(
        icon: Symbol.chevronRight) { }
        .iconColor(.white)
        .style(.secondary)
        .size(.m)
    }
  }
}
