//
//  TUIInputField+Modifiers.swift
//  
//
//  Created by Gopinath on 06/07/23.
//

import SwiftUI

public extension TUIInputFieldProtocol {
  
  func startItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.startItemStyle = show ? style : nil
    return newView
  }
  
  func endItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.endItemStyle = show ? style : nil
    return newView
  }

  func highlightBar(_ show: Bool = true, color: Color) -> some TUIInputFieldProtocol {
    var newView = self
    newView.highlightBar = show ? color : nil
    return newView
  }
  
  func helperText(show: Bool = true, @ViewBuilder _ helperText: () -> TUIHelperText) -> some TUIInputFieldProtocol {
    var newView = self
    newView.helperText = show ? helperText() : nil
    return newView
  }
}

