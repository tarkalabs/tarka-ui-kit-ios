//
//  TUICircularProgressView+Modifiers.swift
//  
//
//  Created by Arvindh Sukumar on 09/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var circularProgressViewStyle: TUICircularProgressViewStyle {
    get { self[TUICircularProgressViewStyle.self] }
    set { self[TUICircularProgressViewStyle.self] = newValue }
  }
}

public extension View {
  func circularProgressViewStyle(_ style: TUICircularProgressViewStyle) -> some View {
    self.environment(\.circularProgressViewStyle, style)
  }
}

