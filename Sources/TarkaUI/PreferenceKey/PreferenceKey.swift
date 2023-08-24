//
//  File.swift
//  
//
//  Created by Gopinath on 24/08/23.
//

import SwiftUI

/// A named value to store height, produced by a view
struct HeightKey: PreferenceKey {
  
  static var defaultValue = CGFloat.zero
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}
