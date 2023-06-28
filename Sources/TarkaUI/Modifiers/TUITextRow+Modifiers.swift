//
//  TUITextRow+Modifiers.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

public extension TUITextRow {
  
  func wrapperIcon(show: Bool = true, @ViewBuilder icon: @escaping () -> TUIWrapperIcon?) -> TUITextRow {
    var newView = self
    newView.wrapperIcon = show ? icon : { nil }
    return newView
  }
  
  func iconButtons(@TUIIconButtonBuilder icons: @escaping () -> [TUIIconButton]) -> TUITextRow {
    var newView = self
    newView.iconButtons = icons
    return newView
  }
}
