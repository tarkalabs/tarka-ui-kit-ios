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
  var menu: [TUIContextMenuSection] = []
  
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
    if !menu.isEmpty {
      Menu(content: sectionView, label: buttonView)
    } else {
      buttonView()
    }
  }
  
  @ViewBuilder
  private func buttonView() -> some View {
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
      .background(style.inputStyle.background)
  }
  
  private func sectionView() -> some View {
    ForEach(menu.indices, id: \.self) { index in
      Section {
        menuView(menu[index])
      } header: {
        if let title = menu[index].title {
          Text(title)
        }
      }
      .accessibilityIdentifier(Accessibility.menuSection(index))
    }
  }
  
  private func menuView(_ row: TUIContextMenuSection) -> some View {
    ForEach(row.menuItems.indices, id: \.self) { index in
      Button(role: row.menuItems[index].role, action: row.menuItems[index].action) {
        Label(
          title: {
            Text(row.menuItems[index].title)
          },
          icon: { 
            row.menuItems[index].icon
          }
        )
      }
      .accessibilityIdentifier(Accessibility.menuItem(index))
    }
  }
  
  struct TUIIconButtonStyle: ButtonStyle {
    let style: Style
    let buttonSize: CGSize
    let isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .frame(width: buttonSize.width, height: buttonSize.height)
        .background(style.inputStyle.background)
        .border(Circle(), width: configuration.isPressed ? 1 : 0,
                color: style.borderColor(configuration.isPressed))
        .isDisabled(isDisabled)
        .contentShape(.circle)
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
  
  public struct InputStyle: Hashable {
    public var background: Color
    public var foreground: Color
    public var border: Color
    
    public init(background: Color, foreground: Color, border: Color) {
      self.background = background
      self.foreground = foreground
      self.border = border
    }
  }
  
  public enum Style: Hashable {
    public static func == (lhs: TUIIconButton.Style, rhs: TUIIconButton.Style) -> Bool {
      switch (lhs, rhs) {
      case (.outline, .outline),
           (.ghost, .ghost),
           (.secondary, .secondary),
           (.primary, .primary):
        return true
      case (.custom(let lhsItem), .custom(let rhsItem)):
        return lhsItem == rhsItem
      default:
        return false
      }
    }
    
    case outline, ghost, secondary, primary,
         custom(InputStyle)
    
    public var inputStyle: InputStyle {
      switch self {
      case .primary:
        return .init(background: .primaryTUI, foreground: .onPrimary, border: .onPrimary)
      case .secondary:
        return .init(background: .secondaryTUI, foreground: .onSecondary, border: .secondaryTUI)
      case .ghost:
        return .init(background: .clear, foreground: .onSurface, border: .clear)
      case .outline:
        return .init(background: .clear, foreground: .onSurface, border: .outline)
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
  enum Accessibility: TUIAccessibility {
    case root
    case menuSection(Int), menuItem(Int)
    
    var identifier: String {
      switch self {
      case .root: return "TUIIconButton"
      case .menuSection(let value): return "MenuSection \(value)"
      case .menuItem(let value): return "MenuItem \(value)"
      }
    }
  }
}

struct IconButtonView_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      TUIIconButton(
        icon: .chevronRight24Filled) { }
        .style(.custom(.init(background: .accentBaseA, foreground: .onAccentBaseA, border: .onAccentBaseA)))
        .size(.size40)
      
      TUIIconButton(
        icon: .chevronRight24Filled) { }
        .style(.primary)
        .size(.size40)
    }
  }
}
