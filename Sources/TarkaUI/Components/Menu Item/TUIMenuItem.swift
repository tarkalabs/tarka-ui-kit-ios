//
//  TUIMenuItem.swift
//  
//
//  Created by Arvindh Sukumar on 27/04/23.
//

import SwiftUI

/// A struct that represents a menu item.
///
/// A menu item can be configured to display a title, description or symbol.
///
/// Example usage:
///
///     TUIMenuItem(
///       title: "Title",
///       style: .withDescription("Description")
///     )
///
/// - Parameters:
///   - title: The title to display in the menu item.
///   - style: The configuration to use to display the menu item. The default value is `.onlyLabel`.
///
public struct TUIMenuItem {
  public var title: any StringProtocol
  public var style: Style
  
  public enum Style {
    /// Displays only the title.
    case onlyLabel
    /// Displays the title and left symbol.
    case leftIcon(FluentIcon)
    /// Displays the title, left and right symbol.
    case withRightIcon(FluentIcon, FluentIcon)
    /// Displays the title and right symbol.
    case rightIcon(FluentIcon)
    case statusDots(FluentIcon, Color)
    /// Displays the title and description.
    case withDescription(String)
    
    func leading(_ isSelected: Bool) -> CGFloat {
      switch self {
      case .onlyLabel: return isSelected ? Spacing.baseHorizontal : Spacing.custom(48)
      case .leftIcon, .withRightIcon, .statusDots: return Spacing.baseHorizontal
      case .rightIcon: return Spacing.custom(48)
      case .withDescription: return Spacing.custom(40)
      }
    }
    
    func trailing(_ isSelected: Bool) -> CGFloat {
      switch self {
      case .onlyLabel: return isSelected ? Spacing.halfHorizontal : Spacing.custom(48)
      case .leftIcon, .withRightIcon, .rightIcon, .statusDots: return Spacing.halfHorizontal
      case .withDescription: return Spacing.custom(40)
      }
    }
    
    func vertical(_ isSelected: Bool) -> CGFloat {
      switch self {
      case .onlyLabel: return isSelected ? Spacing.halfHorizontal : Spacing.custom(10)
      case .leftIcon, .withRightIcon, .rightIcon, .statusDots: return Spacing.halfHorizontal
      case .withDescription: return Spacing.custom(10)
      }
    }
  }
  
  public init(title: any StringProtocol, style: TUIMenuItem.Style) {
    self.title = title
    self.style = style
  }
}
