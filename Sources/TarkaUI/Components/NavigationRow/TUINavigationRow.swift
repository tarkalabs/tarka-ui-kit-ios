//
//  TUINavigationRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

/// A view that displays a navigation row with an optional fluent icon and badge count.
///
/// The navigation row is a horizontal stack with an optional fluent icon, title and an optional extra view.
///
/// `minHeight` of this View is 40. This is to match the exact design of our Design System
///
/// Example usage:
///
///     TUINavigationRow(title: "Label")
///
/// - Parameters:
///   - title: The title to display in the navigation row.
///
public struct TUINavigationRow: View {
  var title: any StringProtocol
  var leftIcon: ImageIconProtocol?
  var isActive = false
  var rightIcon: ImageIconProtocol?
  var badgeCount: Int?
  var showErrorBadge: Bool = false
  
  /// Creates a navigation row with the specified title, symbol and an extra view.
  ///
  /// - Parameters:
  ///   - title: The title to display in the navigation row.
  ///   - symbol: The symbol to display in the navigation row. The default value is `nil`.
  ///   - accessoryView: Extra content to display in the navigation row.
  ///
  public init(
    title: any StringProtocol) {
      self.title = title
    }
  
  public var body: some View {
    
    HStack(spacing: Spacing.baseHorizontal) {
      leftView()
      Spacer()
      rightView()
    }
    // set minHeight to match with design component
    .frame(minHeight: Spacing.custom(40))
    .padding(.horizontal, TarkaUI.Spacing.halfHorizontal)
    .background(isActive ? Color.primaryAlt : Color.clear)
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
    
  }
  
  @ViewBuilder
  func leftView() -> some View {
    
    HStack(spacing: TarkaUI.Spacing.baseHorizontal) {
      
      if let leftIcon {
        Image(icon: leftIcon)
          .resizable()
          .scaledToFit()
          .foregroundColor(isActive ? .onSecondaryAlt : .secondaryTUI)
          .frame(width: 24, height: 24)
          .accessibilityIdentifier(Accessibility.leftIcon)
      }
      
      Text(title)
        .font(.heading7)
        .foregroundColor(.onSurface)
        .frame(minHeight: 18)
        .accessibilityIdentifier(Accessibility.label)
    }
    .frame(minHeight: 24)
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder
  func rightView() -> some View {
    HStack(spacing: TarkaUI.Spacing.quarterHorizontal) {
      
      if showErrorBadge {
        TUIBadge(
          style: .icon(.errorCircle12Regular, .onWarning),
          badgeColor: .warning, size: .size16)
        .accessibilityIdentifier(Accessibility.errorBadge)
      }
      if let badgeCount {
        TUIBadge(
          style: .number(badgeCount),
          badgeColor: .tertiary, size: .size16)
        .accessibilityIdentifier(Accessibility.countBadge)
      }
      if let rightIcon {
        Image(icon: rightIcon)
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(.outline)
      }
    }
  }
}

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

struct NavigationRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      VStack {
        TUINavigationRow(title: "Label")
          .badgeCount(4)
        TUINavigationRow(title: "Label to test with multiple number of lines to verify its adaptability")
        TUINavigationRow(title: "Label")
          .badgeCount(4)
      }
    }
  }
}

// MARK: - Modifiers

public extension TUINavigationRow {
  
  func isActive(_ isPressed: Bool) -> Self {
    var newView = self
    newView.isActive = isPressed
    return newView
  }
  
  func leftIcon(_ icon: ImageIconProtocol, show: Bool = true) -> Self {
    var newView = self
    newView.leftIcon = show ? icon : nil
    return newView
  }
  
  func rightIcon(_ icon: ImageIconProtocol, show: Bool = true) -> Self {
    var newView = self
    newView.rightIcon = show ? icon : nil
    return newView
  }
  
  func badgeCount(_ count: Int, show: Bool = true) -> Self {
    var newView = self
    newView.badgeCount = show ? count : nil
    return newView
  }
  
  func showErrorBadge(_ show: Bool = true) -> Self {
    var newView = self
    newView.showErrorBadge = show
    return newView
  }
}
