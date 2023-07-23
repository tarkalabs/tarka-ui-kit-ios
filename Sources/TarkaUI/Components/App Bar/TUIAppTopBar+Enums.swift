//
//  TUIAppBar+Enums.swift
//  
//
//  Created by Gopinath on 21/07/23.
//

import SwiftUI

public extension TUIAppTopBar {
  
  enum RightButtonType {
    // left to right order
    case none
    case one(BarButtonItem)
    case two(BarButtonItem, BarButtonItem)
    case three(BarButtonItem, BarButtonItem, BarButtonItem)
  }
  
  struct BarButtonItem {
    
    var button: TUIIconButton?
    @Binding var isDisabled: Bool
    
    public init(button: TUIIconButton, isDisabled: Binding<Bool>? = nil) {
      self.button = button
      self._isDisabled = isDisabled ?? Binding<Bool>.constant(false)
    }
  }
  
  enum LeftButton: Identifiable {
    
    public var id: String {
      return UUID().uuidString
    }
    case none, back, cancel
  }
  
  struct BarItem {
    
    var title: String
    var leftButton: LeftButton = .back
    var rightButtons: RightButtonType = .none
    
    public init(title: String, leftButton: LeftButton, rightButtons: RightButtonType = .none) {
      self.title = title
      self.leftButton = leftButton
      self.rightButtons = rightButtons
    }
  }
  
  enum BarStyle {
    
    case titleBar(BarItem)
    case search(TUISearchItem)
  }
}
