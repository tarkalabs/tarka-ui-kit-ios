//
//  PreferenceKeys.swift
//  
//
//  Created by Arvindh Sukumar on 10/08/23.
//

import SwiftUI

/// Use `FloatPreferenceKey` to get and store float values, such as the width/height of the view in which this modifier is applied.
public struct FloatPreferenceKey: PreferenceKey {
  public typealias Value = CGFloat
  public static var defaultValue: CGFloat = 0.0
    
  public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}


