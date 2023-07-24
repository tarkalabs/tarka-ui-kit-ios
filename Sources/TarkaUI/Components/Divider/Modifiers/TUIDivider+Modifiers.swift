//
//  TUIDivider+Modifiers.swift
//  
//
//  Created by Gopinath on 18/07/23.
//

import SwiftUI

public extension TUIDivider {

  /// Sets the foreground color of divider
  func color(_ color: Color) -> Self {
    var newView = self
    newView.color = color
    return newView
  }
}

