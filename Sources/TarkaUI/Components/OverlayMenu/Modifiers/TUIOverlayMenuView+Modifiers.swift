//
//  TUIMobileOverlayMenu+Modifiers.swift
//
//
//  Created by Gopinath on 28/11/23.
//

import SwiftUI

public extension TUIMobileOverlayMenu {
  
  /// Sets padding for centre main view. Default value is `16`
  /// - Parameter padding: value that to be set as hPadding
  /// - Returns: A modified view
  func padding(_ padding: CGFloat) -> TUIMobileOverlayMenu {
    var newView = self
    newView.padding = padding
    return newView
  }
  
  /// Sets vertical gap between `TUIMenuItem`s. Default value is `8`
  /// - Parameter gap: value that to be set as gap among views
  /// - Returns: A modified view
  func verticalGap(_ gap: CGFloat) -> TUIMobileOverlayMenu {
    var newView = self
    newView.verticalGap = gap
    return newView
  }
}
