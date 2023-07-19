//
//  TUIDivider+Modifiers.swift
//  
//
//  Created by Gopinath on 18/07/23.
//

import SwiftUI

public extension TUIDivider {
  
  /// Creates vertical oriented divider with given padding
  /// - Parameters:
  ///   - lrPadding: padding to be set for leading or right
  ///   - tbPadding: padding to be set for top or bottom
  /// - Returns: Modified TUIDivider view
  ///
  func horizontal(
    lrPadding: LRPadding,
    tbPadding: TBPadding) -> Self {
      
      var newView = self
      newView.orientation = .horizontal
      newView.lrPadding = lrPadding.value
      newView.tbPadding = tbPadding.value
      return newView
    }
  
  /// Creates vertical oriented divider with given padding
  /// - Parameter lrPadding: padding to be set for leading or right.
  ///
  /// It has few restriction on combination of lr and tb padding on vertical orientation.
  /// If it is vertical, tb Padding must be `zero` and lr Padding has to be either `zero` or `value 8`.
  /// That's why we use `TBPadding` enum for lrPadding as it has only `zero` and `value 8` options.
  /// - Returns: Modified TUIDivider view
  ///
  func vertical(
    lrPadding: TBPadding) -> Self {
      
      var newView = self
      newView.orientation = .vertical
      newView.lrPadding = lrPadding.value
      newView.tbPadding = 0
      return newView
    }
  
  
  /// Sets the foreground color of divider
  func color(_ color: Color) -> Self {
    var newView = self
    newView.color = color
    return newView
  }
}

