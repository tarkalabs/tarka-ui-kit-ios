//
//  TUITextRow+Modifiers.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

internal struct IconButton {
  var shouldShow: Bool
  var icon: Icon
  var action: () -> Void
}

extension EnvironmentValues {
  
  var infoIcon: IconButton {
    get { self[InfoIconEnvironmentKey.self] }
    set { self[InfoIconEnvironmentKey.self] = newValue }
  }
  
  var iconButton: IconButton {
    get { self[IconButtonEnvironmentKey.self] }
    set { self[IconButtonEnvironmentKey.self] = newValue }
  }
}

struct InfoIconEnvironmentKey: EnvironmentKey {
  static var defaultValue: IconButton = IconButton(shouldShow: false, icon: Symbol.info) { }
}

struct IconButtonEnvironmentKey: EnvironmentKey {
  static var defaultValue: IconButton = IconButton(shouldShow: false, icon: Symbol.info) { }
}


public extension View {
  
  func infoIcon(_ show: Bool = true, action: @escaping () -> Void) -> some View {
    environment(\.infoIcon, IconButton(shouldShow: show, icon: Symbol.info, action: action))
  }
  
  func iconButton(_ show: Bool = true, icon: Icon,
                  action: @escaping () -> Void) -> some View {
    environment(\.iconButton, IconButton(shouldShow: show, icon: icon, action: action))
  }
}
