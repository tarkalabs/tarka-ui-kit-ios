//
//  TUIBody+Modifiers.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI

public extension TUIInputField {
  
  func startItem(_ item: TUIInputField.AdditionalItem) -> TUIInputField {
    var newView = self
    newView.startItem = item
    return newView
  }
  
  func endItem(_ item: TUIInputField.AdditionalItem) -> TUIInputField {
    var newView = self
    newView.endItem = item
    return newView
  }

  func highlightBar(_ show: Bool = true) -> TUIInputField {
    var newView = self
    newView.highlightBar = show
    return newView
  }
  
  func helpText(_ text: String? = nil) -> TUIInputField {
    var newView = self
    newView.helpText = text
    return newView
  }
}
