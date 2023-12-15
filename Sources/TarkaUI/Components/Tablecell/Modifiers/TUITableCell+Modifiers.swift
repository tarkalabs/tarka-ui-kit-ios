//
//  TUITableCell+Modifiers.swift
//
//
//  Created by Gopinath on 29/11/23.
//

import SwiftUI

public extension TUITableCell {
  
  func borderStyle(_ style: TUITableCell.BorderStyle) -> Self {
    var newView = self
    newView.borderStyle = style
    return newView
  }
  
  func isHeader(_ isHeader: Bool) -> Self {
    var newView = self
    newView.isHeader = isHeader
    return newView
  }
}
