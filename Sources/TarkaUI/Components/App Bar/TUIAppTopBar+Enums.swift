//
//  TUIAppBar+Enums.swift
//  
//
//  Created by Gopinath on 21/07/23.
//

import SwiftUI

public typealias TUIButtonAction = () -> Void

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
    case none, back(TUIButtonAction), cancel(TUIButtonAction)
    
    var leading: CGFloat {
      switch self {
      case .none: return 16
      default: return 0
      }
    }
  }
  
  struct BarItem {
    
    var title: String
    var leftButton: LeftButton
    var rightButtons: RightButtonType = .none
    
    public init(title: String, leftButton: LeftButton, rightButtons: RightButtonType = .none) {
      self.title = title
      self.leftButton = leftButton
      self.rightButtons = rightButtons
    }
  }
  
  struct SearchBarItem {
    public var item: TUISearchItem
    var backAction: TUIButtonAction
    
    public init(item: TUISearchItem, backAction: @escaping TUIButtonAction) {
      self.item = item
      self.backAction = backAction
    }
  }
  
  enum BarStyle {
    
    case titleBar(BarItem)
    case search(SearchBarItem)
    
    var minHeight: CGFloat {
      
      if case .titleBar(let barItem) = self {
        
        if case .none = barItem.leftButton ,
           case .none = barItem.rightButtons {
          return 60
        }
      }
      return 64
    }
    
    var extraPadding: CGFloat {
      let padding: CGFloat = minHeight == 64 ? 2 : 0
      return padding + 2
    }
  }
}
