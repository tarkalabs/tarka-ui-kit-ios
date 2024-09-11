//
//  TUITip.swift
//
//
//  Created by Navin Kumar on 11/09/24.
//

import Foundation
import TipKit

public struct TUITip {
  public var tip: Any?
  public var arrowEdge: Edge?
  public var action: (() -> Void)?
  
  public init(tip: Any?, arrowEdge: Edge? = .top, action: (() -> Void)? = nil) {
    self.tip = tip
    self.arrowEdge = arrowEdge
    self.action = action
  }
}
