//
//  TUIAppBar+Enums.swift
//  
//
//  Created by Gopinath on 21/07/23.
//

import SwiftUI

public typealias TUIButtonAction = () -> Void

public extension TUIAppTopBar {
  
  /// Defines the navigation bar style
  enum BarStyle {
    
    /// Assigns title and bar button items
    case titleBar(TitleBarItem)
    
    /// Shows search bar with back and cancel buttons
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
  }
  
  struct TitleBarItem {
    
    var title: String
    var bottom: BottomContent
    var leftButton: LeftButton
    var rightButtons: RightButtonType
    
    public init(title: String,
                bottom: BottomContent = .none,
                leftButton: LeftButton,
                rightButtons: RightButtonType = .none) {
      
      self.title = title
      self.bottom = bottom
      self.leftButton = leftButton
      self.rightButtons = rightButtons
    }
  }
  
  enum BottomContent {
    case none, tabs(TUITabBar)
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
  
  struct SearchBarItem {
    
    var item: TUISearchItem
    var backAction: TUIButtonAction
    
    public init(item: TUISearchItem, backAction: @escaping TUIButtonAction) {
      self.item = item
      self.backAction = backAction
    }
  }
}
