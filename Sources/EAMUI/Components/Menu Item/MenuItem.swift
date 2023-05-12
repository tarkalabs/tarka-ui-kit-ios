//
//  MenuItem.swift
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
///     MenuItem(
///       title: "Title",
///       configuration: .withDescription("Description")
///     )
///
/// - Parameters:
///   - title: The title to display in the menu item.
///   - configuration: The configuration to use to display the menu item. The default value is `.onlyLabel`.
///
public struct MenuItem {
  public var title: any StringProtocol
  public var configuration: Configuration
  
  public enum Configuration {
    /// Displays only the title.
    case onlyLabel
    /// Displays the title and description.
    case withDescription(String)
    /// Displays the title and symbol.
    case withSymbol(EAMSymbol)
  }
  
  public init(title: any StringProtocol, configuration: MenuItem.Configuration) {
    self.title = title
    self.configuration = configuration
  }
}
