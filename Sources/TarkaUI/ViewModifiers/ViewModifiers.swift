//
//  ViewModifiers.swift
//  
//
//  Created by Gopinath on 14/08/23.
//

import SwiftUI


public struct DisabledView: ViewModifier {
  
  var isDisabled = false
  
  public init(isDisabled: Bool = false) {
    self.isDisabled = isDisabled
  }
  
  public func body(content: Content) -> some View {
    content
      .disabled(isDisabled)
      .opacity(isDisabled ? 0.5 : 1)
  }
}
