//
//  TUIMenuItemProperties.swift
//  
//
//  Created by Arvindh Sukumar on 27/04/23.
//

import SwiftUI

/// A struct that represents a menu item.
///
/// A menu item can be configured to display a title, description or fluent icon.
///
/// Example usage:
///
///     TUIMenuItemProperties(
///       title: "Title",
///       style: .withDescription("Description")
///     )
///
/// - Parameters:
///   - title: The title to display in the menu item.
///   - style: The configuration to use to display the menu item. The default value is `.onlyLabel`.
///
public struct TUIMenuItemProperties: Identifiable, Equatable {
  public static func == (lhs: TUIMenuItemProperties, rhs: TUIMenuItemProperties) -> Bool {
    lhs.title == rhs.title
  }
  
  public var title: String
  public var style: Style
  public var id: String
  
  public enum Style {
    /// Displays only the title.
    case onlyLabel
    /// Displays the title and left image.
    case leftImage(ImageIconProtocol)
    /// Displays the title, left and right symbol.
    case withRightIcon(FluentIcon, FluentIcon)
    /// Displays the title and right symbol.
    case rightIcon(FluentIcon)
    /// Displays the title and status Dots.
    case statusDots(FluentIcon, Color)
    /// Displays the title and description.
    case withDescription(String)
    
    func leading(_ isSelected: Bool) -> CGFloat {
      switch self {
      case .onlyLabel: return isSelected ? Spacing.baseHorizontal : Spacing.custom(48)
      case .leftImage, .withRightIcon, .statusDots: return Spacing.baseHorizontal
      case .rightIcon: return Spacing.custom(48)
      case .withDescription: return Spacing.custom(40)
      }
    }
    
    func trailing(_ isSelected: Bool) -> CGFloat {
      switch self {
      case .onlyLabel: return isSelected ? Spacing.halfHorizontal : Spacing.custom(48)
      case .leftImage, .withRightIcon, .rightIcon, .statusDots: return Spacing.halfHorizontal
      case .withDescription: return Spacing.custom(40)
      }
    }
    
    func vertical(_ isSelected: Bool) -> CGFloat {
      switch self {
      case .onlyLabel: return isSelected ? Spacing.halfHorizontal : Spacing.custom(10)
      case .leftImage, .withRightIcon, .rightIcon, .statusDots: return Spacing.halfHorizontal
      case .withDescription: return Spacing.custom(10)
      }
    }
    
    func height(_ isSelected: Bool) -> CGFloat {
      switch self {
      case .onlyLabel, .leftImage,
          .withRightIcon: return isSelected ? Spacing.custom(40) : Spacing.custom(38)
      case .rightIcon: return Spacing.custom(36)
      case .statusDots: return isSelected ? Spacing.custom(40) : Spacing.custom(34)
      case .withDescription: return Spacing.custom(62)
      }
    }
    
    func isEnabled(_ isSelected: Bool) -> Bool {
      switch self {
      case .withRightIcon, .rightIcon, .withDescription: return false
      default: return isSelected
      }
    }
  }
  
  public init(title: String, style: TUIMenuItemProperties.Style,
              id: String = UUID().uuidString) {
    self.title = title
    self.style = style
    self.id = id
  }
}
