//
//  TUIBody+Modifiers.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI

public extension TUIInputField {
  
  func startItem(show: Bool = true, withStyle style: TUIInputAdditionalItem.Style) -> TUIInputField {
    var newView = self
    newView.startItemStyle = show ? style : nil
    return newView
  }
  
  func endItem(show: Bool = true, withStyle style: TUIInputAdditionalItem.Style) -> TUIInputField {
    var newView = self
    newView.endItemStyle = show ? style : nil
    return newView
  }

  func highlightBar(_ show: Bool = true) -> TUIInputField {
    var newView = self
    newView.showHighlightBar = show
    return newView
  }
  
  func helperText(show: Bool = true, @ViewBuilder _ helperText: () -> TUIHelperText) -> TUIInputField {
    var newView = self
    newView.helperText = show ? helperText() : nil
    return newView
  }
}
