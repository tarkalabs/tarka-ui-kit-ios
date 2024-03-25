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

  public enum Size {
    case size20, size24, size32, size40, size48
  }
  
  public let id = UUID()
  /// The icon to display in the button.
  /// 
  public var icon: FluentIcon
  
  var iconColor: Color?

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
    Button(action: action, label: iconView)
      .buttonStyle(TUIIconButtonStyle(
        style: style,
        buttonSize: buttonSize,
        isDisabled: isDisabled))
      .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private func iconView() -> some View {
    Image(fluent: icon)
      .scaledToFit()
      .frame(
        width: iconSize.width,
        height: iconSize.height
      )
      .clipped()
      .foregroundColor(iconColor ?? style.inputStyle.foreground)
  }
  
  struct TUIIconButtonStyle: ButtonStyle {
    let style: Style
    let buttonSize: CGSize
    let isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .frame(width: buttonSize.width, height: buttonSize.height)
        .background(style.inputStyle.background)
        .border(Circle(), width: configuration.isPressed ? ceil(1.5) : 0,
                color: style.borderColor(configuration.isPressed))
        .isDisabled(isDisabled)
    }
  }
}

extension TUIIconButton {
  
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
  
  public struct InputStyle {
    public var background: Color
    public var foreground: Color
    public var border: Color
    
    public init(_ background: Color, foreground: Color, border: Color) {
      self.background = background
      self.foreground = foreground
      self.border = border
    }
  }
  
  public enum Style {
    case outline, ghost, secondary, primary,
         custom(InputStyle)
    
    public var inputStyle: InputStyle {
      switch self {
      case .primary:
        return .init(.primaryTUI, foreground: .onPrimary, border: .onPrimary)
      case .secondary:
        return .init(.secondaryTUI, foreground: .onSecondary, border: .secondaryTUI)
      case .ghost:
        return .init(.clear, foreground: .onSurface, border: .clear)
      case .outline:
        return .init(.clear, foreground: .onSurface, border: .outline)
      case .custom(let item):
        return item
      }
    }
    
    func borderColor(_ isPressed: Bool) -> Color {
      switch self {
      case .primary:
        return isPressed ? .onSurface : .onPrimary
      case .secondary, .ghost:
        return .clear
      case .outline:
        return isPressed ? .onSurface : .outline
      case .custom(let item):
        return isPressed ? item.foreground : item.border
      }
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
    HStack {
      TUIIconButton(
        icon: .chevronRight24Filled) { }
        .style(.custom(.init(.accentBaseA, foreground: .onAccentBaseA, border: .onAccentBaseA)))
        .size(.size40)
      
      TUIIconButton(
        icon: .chevronRight24Filled) { }
        .style(.primary)
        .size(.size40)
    }
  }
}
