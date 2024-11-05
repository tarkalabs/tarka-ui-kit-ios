//
//  TUIAppBottomBar+Enums.swift
//
//
//  Created by Arvindh Sukumar on 05/06/24.
//

import Foundation

public extension TUIAppBottomBar {
  struct Item: Identifiable, Hashable {
    public static func == (lhs: TUIAppBottomBar.Item, rhs: TUIAppBottomBar.Item) -> Bool {
      lhs.id == rhs.id &&
      lhs.isEnabled == rhs.isEnabled &&
      lhs.icon.resourceString == rhs.icon.resourceString &&
      lhs.style == rhs.style
    }
    
    public var id: String
    public var icon: FluentIcon
    public var isEnabled: Bool
    public var style: TUIIconButton.Style
    public var action: () -> Void
    
    public init(id: String, icon: FluentIcon, isEnabled: Bool, style: TUIIconButton.Style = .ghost, action: @escaping () -> Void) {
      self.id = id
      self.icon = icon
      self.isEnabled = isEnabled
      self.style = style
      self.action = action
    }
    
    public func hash(into hasher: inout Hasher) {
      hasher.combine(id)
      hasher.combine(isEnabled)
      hasher.combine(icon.resourceString)
      hasher.combine(style)
    }
  }
}
