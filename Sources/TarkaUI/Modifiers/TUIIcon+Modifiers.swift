//
//  TUIWrapperIcon+Modifiers.swift
//  
//
//  Created by Gopinath on 12/06/23.
//

import SwiftUI

extension EnvironmentValues {
  
  var iconColor: Color {
    get { self[
      IconColorEnvironmentKey.self] }
    set { self[IconColorEnvironmentKey.self] = newValue }
  }
}

struct IconColorEnvironmentKey: EnvironmentKey {
  static var defaultValue: Color = .disabledContent
}
