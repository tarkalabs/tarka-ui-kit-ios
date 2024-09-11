//
//  PopOverTip.swift
//  
//
//  Created by Navin Kumar on 11/09/24.
//

import SwiftUI
import TipKit

// Custom view modifier for applying popover tips
struct PopOverTip: ViewModifier {
  
  var tip: TUITip?
  var arrowEdge: Edge
  var action: (() -> Void)?
  
  @ViewBuilder
  func body(content: Content) -> some View {
    if #available(iOS 17.0, *), let tip = tip?.tip as? (any Tip) {
      content
        .popoverTip(AnyTip(tip), arrowEdge: arrowEdge, action: { _ in
          if let action {
            action()
          }
        })
    } else {
      content
    }
  }
}
