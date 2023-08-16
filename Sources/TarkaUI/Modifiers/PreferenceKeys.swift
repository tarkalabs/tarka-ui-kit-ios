//
//  PreferenceKeys.swift
//  
//
//  Created by Arvindh Sukumar on 10/08/23.
//

import SwiftUI

public struct FloatPreferenceKey: PreferenceKey {
  public typealias Value = CGFloat
  public static var defaultValue: CGFloat = 0.0
    
  public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}


