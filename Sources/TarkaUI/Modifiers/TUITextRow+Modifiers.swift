//
//  TUITextRow+Modifiers.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

public extension TUITextRow {
  
  func wrapperIcon(@ViewBuilder icon: @escaping () -> TUIWrapperIcon?) -> TUITextRow {
    var newView = self
    newView.wrapperIcon = icon
    return newView
  }
  
  func infoIcon(color: Color? = nil,
                action: @escaping () -> Void) -> TUITextRow {
    var newView = self
    let infoIcon: () -> TUIWrapperIcon = {
      TUIWrapperIcon.info(color: color, action: action)
    }
    newView.wrapperIcon = infoIcon
    return newView
  }
  
  func iconButtons(@TUIIconButtonBuilder icons: @escaping () -> [TUIIconButton]) -> TUITextRow {
    var newView = self
    newView.iconButtons = icons
    return newView
  }
}
