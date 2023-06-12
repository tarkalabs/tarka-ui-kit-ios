//
//  TUITextRow+Modifiers.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

internal struct IconButton {
  var shouldShow: Bool
  var image: Icon
  var action: () -> Void
}

extension EnvironmentValues {
  
  var wrapperIcon: IconButton {
    get { self[WrapperIconEnvironmentKey.self] }
    set { self[WrapperIconEnvironmentKey.self] = newValue }
  }
  
  var iconButton: IconButton {
    get { self[IconButtonEnvironmentKey.self] }
    set { self[IconButtonEnvironmentKey.self] = newValue }
  }
}

struct WrapperIconEnvironmentKey: EnvironmentKey {
  static var defaultValue: IconButton = IconButton(shouldShow: false, image: Symbol.info) { }
}

struct IconButtonEnvironmentKey: EnvironmentKey {
  static var defaultValue: IconButton = IconButton(shouldShow: false, image: Symbol.info) { }
}


public extension View {
  
  func wrapperIcon(_ show: Bool = true, image: Icon,
                   action: @escaping () -> Void) -> some View {
    environment(\.wrapperIcon, IconButton(shouldShow: show, image: image, action: action))  }
  
  func infoIcon(_ show: Bool = true,
                   action: @escaping () -> Void) -> some View {
    environment(\.wrapperIcon, IconButton(shouldShow: show, image: Symbol.info, action: action))  }
  
  func iconButton(_ show: Bool = true, image: Icon,
                  action: @escaping () -> Void) -> some View {
    environment(\.iconButton, IconButton(shouldShow: show, image: image, action: action))
  }
}
