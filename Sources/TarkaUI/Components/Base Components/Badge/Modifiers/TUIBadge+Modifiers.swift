//
//  TUIBadge+Modifiers.swift
//  
//
//  Created by Arvindh Sukumar on 10/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var badgeSize: BadgeSize {
    get { self[BadgeSize.self] }
    set { self[BadgeSize.self] = newValue }
  }
}

public extension View {
  func badgeSize(_ size: BadgeSize) -> some View {
    environment(\.badgeSize, size)
  }
}
