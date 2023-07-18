//
//  TUIDivider+Modifiers.swift
//  
//
//  Created by Gopinath on 18/07/23.
//

import SwiftUI

public extension TUIDivider {
  
  func horizontal(
    lrPadding: LRPadding,
    tbPadding: TBPadding) -> Self {
      
      var newView = self
      newView.orientation = .horizontal
      newView.lrPadding = lrPadding.value
      newView.tbPadding = tbPadding.value
      return newView
    }
  
  func vertical(
    lrPadding: TBPadding) -> Self {
      
      var newView = self
      newView.orientation = .vertical
      newView.lrPadding = lrPadding.value
      newView.tbPadding = 0
      return newView
    }
  
  func color(_ color: Color) -> Self {
    var newView = self
    newView.color = color
    return newView
  }
}

