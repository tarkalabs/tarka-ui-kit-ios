//
//  TUIContextMenuItem.swift
//
//
//  Created by Arvindh Sukumar on 03/06/24.
//

import SwiftUI

public struct TUIContextMenuItem: Hashable {
  public var title: String
  public var icon: Image
  public var iconSize: CGSize
  public var role: ButtonRole?
  public var action: () -> Void
  
  public init(_ title: String, icon: Image,
              role: ButtonRole? = nil,
              iconSize: CGSize = .init(width: 24, height: 24),
              action: @escaping () -> Void) {
    self.title = title
    self.icon = icon
    self.role = role
    self.iconSize = iconSize
    self.action = action
  }
  
  public static func == (lhs: TUIContextMenuItem, rhs: TUIContextMenuItem) -> Bool {
    lhs.title == rhs.title
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(title)
  }
}

public struct TUIContextMenuSection: Identifiable {
  public var id: String
  public var title: String?
  public var menuItems: [TUIContextMenuItem]
  
  public init(title: String? = nil, id: String = UUID().uuidString,
       menuItems: [TUIContextMenuItem]) {
    self.title = title
    self.menuItems = menuItems
    self.id = id
  }
}
