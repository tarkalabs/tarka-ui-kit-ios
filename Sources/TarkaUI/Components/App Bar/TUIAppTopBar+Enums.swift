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
    case search(TUISearchBarViewModel)
  }
  
  struct TitleBarItem {
    
    var title: String?
    var attributedTitle: AttributedString?
    var bottom: BottomContent
    var leftButton: LeftButton
    var rightButtons: [TUIIconButton]
    
    public init(title: String,
                bottom: BottomContent = .none,
                leftButton: LeftButton,
                rightButtons: [TUIIconButton] = []) {
      
      self.title = title
      self.bottom = bottom
      self.leftButton = leftButton
      self.rightButtons = rightButtons
    }
    
    public init(attributedTitle: AttributedString,
                bottom: BottomContent = .none,
                leftButton: LeftButton,
                rightButtons: [TUIIconButton] = []) {
      
      self.attributedTitle = attributedTitle
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
    case none, back(TUIButtonAction? = nil), cancel(TUIButtonAction? = nil), custom(TUIIconButton)
    
    var leading: CGFloat {
      switch self {
      case .none: return 16
      default: return 0
      }
    }
  }
}
