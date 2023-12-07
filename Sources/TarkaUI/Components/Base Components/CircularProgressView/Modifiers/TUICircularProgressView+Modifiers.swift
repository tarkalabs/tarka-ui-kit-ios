//
//  TUICircularProgressView+Modifiers.swift
//  
//
//  Created by Arvindh Sukumar on 09/05/23.
//

import SwiftUI

public extension TUICircularProgressView {
  
  func backgroundCircleColor(_ color: Color? = nil) -> Self {
    guard let color else { return self }
    var newView = self
    newView.backgroundCircleColor = color
    return newView
  }

  func circularProgressViewStyle(_ style: TUICircularProgressViewStyle) -> Self {
    var newView = self
    newView.style = style
    return newView
  }
}

