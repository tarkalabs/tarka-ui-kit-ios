//
//  TUINavigationRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

/// A view that displays a navigation row with an optional ImageIconProtocol icon and badge count.
///
/// The navigation row is a horizontal stack with an optional ImageIconProtocol icon, title and an optional extra view.
///
/// `minHeight` of this View is 40. This is to match the exact design of our Design System
///
/// Example usage:
///
///     TUINavigationRow(title: "Label") { }
///
/// - Parameters:
///   - title: The title to display in the navigation row.
///   - action: The action to perform when the TUINavigationRow item is tapped.
///
/// - Returns: A closure that returns the content
///
public struct TUINavigationRow: View {
  
  private var title: any StringProtocol
  
  private var inputStyle: InputStyle
  
  private var action: () -> Void
  
  /// Creates a navigation row with the specified title, symbol and an extra view.
  ///
  /// - Parameters:
  ///   - title: The title to display in the navigation row.
  ///   - action: The action to perform when the TUINavigationRow item is tapped.
  ///
  public init(title: any StringProtocol, action: @escaping () -> Void) {
    self.title = title
    self.action = action
    inputStyle = .init()
  }
  
  public var body: some View {
    Button(action: action, label: mainView)
      .buttonStyle(NavigationRowButtonStyle(for: inputStyle))
      .accessibilityElement(children: .contain)
      .accessibilityIdentifier(Accessibility.root)
  }
  
  private func mainView() -> some View {
    HStack(spacing: Spacing.baseHorizontal) {
      leftView
      rightView
    }
    .padding(Spacing.baseVertical)
  }
  
  @ViewBuilder
  private var leftView: some View {
    
    HStack(spacing: TarkaUI.Spacing.baseHorizontal) {
      
      if let leftIcon = inputStyle.leftIcon {
        Image(icon: leftIcon)
          .resizable()
          .scaledToFit()
          .foregroundColor(inputStyle.isActive ? .onSecondaryAlt : .secondaryTUI)
          .frame(width: 24, height: 24)
          .accessibilityIdentifier(Accessibility.leftIcon)
      }
      
      Text(title)
        .font(.heading7)
        .foregroundColor(inputStyle.isActive ? .onSecondaryAlt : .onSurface)
        .frame(minHeight: 18)
        .lineLimit(1)
        .accessibilityIdentifier(Accessibility.label)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder
  private var rightView: some View {
    HStack(spacing: TarkaUI.Spacing.quarterHorizontal) {
      
      if inputStyle.showErrorBadge {
        TUIBadge(
          style: .icon(.errorCircle12Regular, .onWarning),
          badgeColor: .warning, size: .size16)
        .accessibilityIdentifier(Accessibility.errorBadge)
      }
      
      if let badgeCount = inputStyle.badgeCount {
        
        TUIBadge(
          style: .number(badgeCount),
          badgeColor: .tertiary, size: .size16)
        .accessibilityIdentifier(Accessibility.countBadge)
      }
      
      if let rightIcon = inputStyle.rightIcon {
        Image(icon: rightIcon)
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(.outline)
      }
    }
  }
}

// MARK: - Input Style

extension TUINavigationRow {
  
  struct InputStyle {
    var leftIcon: ImageIconProtocol?
    var isActive = false
    var rightIcon: ImageIconProtocol?
    var badgeCount: Int?
    var showErrorBadge: Bool = false
    
    var backgroundColor = InputColorStyle()
    
    init(leftIcon: ImageIconProtocol? = nil,
         rightIcon: ImageIconProtocol? = nil,
         isActive: Bool = false,
         badgeCount: Int? = nil,
         showErrorBadge: Bool = false) {
      self.leftIcon = leftIcon
      self.isActive = isActive
      self.rightIcon = rightIcon
      self.badgeCount = badgeCount
      self.showErrorBadge = showErrorBadge
    }
    
    func activeColor(for isPressed: Bool) -> Color {
      isPressed ? backgroundColor.isPressedSelectionColor : backgroundColor.selectionColor
    }
    
    func backgroundColor(for isPressed: Bool) -> Color {
      isPressed ? backgroundColor.isPressedColor : backgroundColor.color
    }
  }
  
  public struct InputColorStyle {
    var color: Color
    var isPressedColor: Color
    
    var selectionColor: Color
    var isPressedSelectionColor: Color
    
    public init(color: Color = .surface,
                isPressedColor: Color = .surfaceHover,
                selectionColor: Color = .secondaryAlt,
                isPressedSelectionColor: Color = .secondaryAltHover) {
      
      self.color = color
      self.selectionColor = selectionColor
      self.isPressedColor = isPressedColor
      self.isPressedSelectionColor = isPressedSelectionColor
    }
  }
  
  // MARK: - ButtonStyle
  
  struct NavigationRowButtonStyle: ButtonStyle {
    
    let style: InputStyle
    
    init(for style: InputStyle) {
      self.style = style
    }
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .frame(minHeight: Spacing.custom((style.leftIcon != nil) ? 40 : 36))
        .background(background(configuration.isPressed),
                    in: .rect(cornerRadius: Spacing.baseVertical))
    }
    
    func background(_ isPressed: Bool) -> Color {
      if style.isActive {
        return style.activeColor(for: isPressed)
      } else {
        return style.backgroundColor(for: isPressed)
      }
    }
  }
}

// MARK: - Accessibility

extension TUINavigationRow {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUINavigationRow"
    case leftIcon = "LeftIcon"
    case label = "Label"
    case rightIcon = "rightIcon"
    case countBadge = "CountBadge"
    case errorBadge = "ErrorBadge"
  }
}

// MARK: - Modifiers

public extension TUINavigationRow {
  
  func isActive(_ isPressed: Bool) -> Self {
    var newView = self
    newView.inputStyle.isActive = isPressed
    return newView
  }
  
  func leftIcon(_ icon: ImageIconProtocol, show: Bool = true) -> Self {
    var newView = self
    newView.inputStyle.leftIcon = show ? icon : nil
    return newView
  }
  
  func rightIcon(_ icon: ImageIconProtocol, show: Bool = true) -> Self {
    var newView = self
    newView.inputStyle.rightIcon = show ? icon : nil
    return newView
  }
  
  func badgeCount(_ count: Int, show: Bool = true) -> Self {
    var newView = self
    newView.inputStyle.badgeCount = show ? count : nil
    return newView
  }
  
  func showErrorBadge(_ show: Bool = true) -> Self {
    var newView = self
    newView.inputStyle.showErrorBadge = show
    return newView
  }
  
  func color(_ style: InputColorStyle) -> Self {
    var newView = self
    newView.inputStyle.backgroundColor = style
    return newView
  }
}

// MARK: - Preview

struct NavigationRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      VStack {
        TUINavigationRow(title: "Label") { }
          .badgeCount(4)
        
        TUINavigationRow(title: "Label to test with multiple number of lines to verify its adaptability") {}
          .rightIcon(FluentIcon.chevronRight20Filled)
        
        TUINavigationRow(title: "Label") {}
          .badgeCount(4)
          .isActive(true)
          .rightIcon(FluentIcon.chevronRight20Filled)
          .showErrorBadge()
      }
      .padding(8)
    }
  }
}
