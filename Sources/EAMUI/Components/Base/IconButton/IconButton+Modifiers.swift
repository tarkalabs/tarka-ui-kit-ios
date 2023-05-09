//
//  File.swift
//  
//
//  Created by Arvindh Sukumar on 09/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var iconButtonStyle: IconButtonStyle {
    get { self[IconButtonStyle.self] }
    set { self[IconButtonStyle.self] = newValue }
  }
  
  var iconButtonSize: IconButtonSize {
    get { self[IconButtonSize.self] }
    set { self[IconButtonSize.self] = newValue }
  }
}

public extension View {
  func iconButtonStyle(_ style: IconButtonStyle) -> some View {
    self.environment(\.iconButtonStyle, style)
  }
  
  func iconButtonSize(_ size: IconButtonSize) -> some View {
    self.environment(\.iconButtonSize, size)
  }
}
