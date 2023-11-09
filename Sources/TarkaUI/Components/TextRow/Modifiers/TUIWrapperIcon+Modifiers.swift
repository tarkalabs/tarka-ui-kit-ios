//
//  TUIWrapperIcon+Modifiers.swift
//  
//
//  Created by Gopinath on 28/06/23.
//

import SwiftUI

public extension TUIWrapperIcon {
  
  func iconColor(_ color: Color) -> TUIWrapperIcon {
    var newView = self
    newView.color = color
    return newView
  }
 
  func action(action: @escaping () -> Void) -> TUIWrapperIcon {
    var newView = self
    newView.action = action
    newView.disableInteraction = false
    return newView
  }
}
