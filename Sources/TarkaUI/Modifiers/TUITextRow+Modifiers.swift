//
//  TUITextRow+Modifiers.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

internal struct InfoIcon {
  var shouldShow: Bool
  var action: (() -> Void)? = nil
}
extension EnvironmentValues {
  var infoIcon: InfoIcon {
    get { self[InfoIconEnvironmentKey.self] }
    set { self[InfoIconEnvironmentKey.self] = newValue }
  }
}

struct InfoIconEnvironmentKey: EnvironmentKey {
  static var defaultValue: InfoIcon = InfoIcon(shouldShow: false)
}

public extension View {
  func infoIcon(_ show: Bool = false, action: (() -> Void)? = nil) -> some View {
    environment(\.infoIcon, InfoIcon(shouldShow: true, action: action))
  }
}
