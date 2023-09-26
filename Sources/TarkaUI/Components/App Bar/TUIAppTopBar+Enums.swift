//
//  TUIAppBar+Enums.swift
//  
//
//  Created by Gopinath on 21/07/23.
//

import SwiftUI

public typealias TUIButtonAction = () -> Void

let keyWindow = UIApplication.shared.connectedScenes
  .compactMap({$0 as? UIWindowScene})
  .first?.windows
  .filter({$0.isKeyWindow}).first

public extension TUIAppTopBar {
  
  /// Defines the navigation bar style
  enum BarStyle {
    
    /// Assigns title and bar button items
    case titleBar(TitleBarItem)
    
    /// Shows search bar with back and cancel buttons
    case search(TUISearchBarViewModel)
    
    var minHeight: CGFloat {
      
      if case .titleBar(let barItem) = self {
        
        if case .none = barItem.leftButton ,
           case .none = barItem.rightButtons {
          return 60
        }
      }
      return 64 + topPadding
    }

    var topPadding: CGFloat {
      
      // It is to give extra padding for dynamic island supported devices
      // as it has more top inset than others that causes padding issue
      let expectedSafeArea: CGFloat = 50
      guard let topInsets = keyWindow?.safeAreaInsets.top,
            topInsets > expectedSafeArea else {
        return 0
      }
      return topInsets - expectedSafeArea
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
    case none, back(TUIButtonAction? = nil), cancel(TUIButtonAction? = nil)
    
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
    case one(TUIIconButton)
    case two(TUIIconButton, TUIIconButton)
    case three(TUIIconButton, TUIIconButton, TUIIconButton)
  }
}
