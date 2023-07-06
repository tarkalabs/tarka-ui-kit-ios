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
    newView.properties.startItemStyle = show ? style : nil
    return newView
  }
  
  func endItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.endItemStyle = show ? style : nil
    return newView
  }

  func highlightBar(_ show: Bool = true, color: Color) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.highlightBar = show ? color : nil
    return newView
  }
  
  func helperText(show: Bool = true, @ViewBuilder _ helperText: () -> TUIHelperText) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.helperText = show ? helperText() : nil
    return newView
  }
  
  func placeholder(_ value: String) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.placeholder = value
    return newView
  }
}

