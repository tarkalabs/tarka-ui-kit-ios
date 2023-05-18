//
//  CircularProgressView+Modifiers.swift
//  
//
//  Created by Arvindh Sukumar on 09/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var circularProgressViewStyle: CircularProgressViewStyle {
    get { self[CircularProgressViewStyle.self] }
    set { self[CircularProgressViewStyle.self] = newValue }
  }
}

public extension View {
  func circularProgressViewStyle(_ style: CircularProgressViewStyle) -> some View {
    self.environment(\.circularProgressViewStyle, style)
  }
}

