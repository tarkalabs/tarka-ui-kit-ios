//
//  TUIButtonSize.swift
//
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public extension TUIButton {
  
  enum Size: String, Identifiable, CaseIterable {
    
    case xl, large, regular, small, xs
    
    public var id: String {
      UUID().uuidString
    }
    
    var height: CGFloat {
      switch self {
      case .xl: return 56
      case .large: return 48
      case .regular: return 40
      case .small: return 32
      case .xs: return 24
      }
    }
    
    var titleHeight: CGFloat {
      switch self {
      case .xl, .large, .regular: return 20
      case .small: return 18
      case .xs: return 14
      }
    }
    
    var iconSize: CGFloat {
      switch self {
      case .xl, .large, .regular: return 24
      case .small, .xs: return 16
      }
    }
    
    var hStackTopPadding: CGFloat {
      switch self {
      case .xl: return Spacing.custom(14)
      case .large: return Spacing.custom(12)
      case .regular: return Spacing.halfHorizontal
      case .small: return Spacing.custom(7)
      case .xs: return Spacing.custom(5)
      }
    }
    
    var hStackSpacing: CGFloat {
      switch self {
      case .xl, .large, .regular: return Spacing.halfHorizontal
      case .small, .xs: return Spacing.quarterHorizontal
      }
    }
    
    var titleTopPadding: CGFloat {
      switch self {
      case .xl, .large, .regular: return Spacing.custom(2)
      case .small, .xs: return 0
      }
    }
    
    var buttonSize: Font {
      switch self {
      case .xl, .large, .regular: return .button6
      case .small: return .button7
      case .xs: return .button8
      }
    }
    
    func leading(for icon: TUIButton.Icon?) -> CGFloat {
      guard let icon else {
        return paddingWithTitle
      }
      switch icon {
      case .right: return paddingWithTitle
      case .left: return paddingWithIcon
      }
    }
    
    func trailing(for icon: TUIButton.Icon?) -> CGFloat {
      
      guard let icon else {
        return paddingWithTitle
      }
      switch icon {
      case .right: return paddingWithIcon
      case .left: return paddingWithTitle
      }
    }
    
    private var paddingWithTitle: CGFloat {
      switch self {
      case .xl, .large, .regular: return Spacing.custom(24)
      case .small: return Spacing.baseHorizontal
      case .xs: return Spacing.halfHorizontal
      }
    }
    
    private var paddingWithIcon: CGFloat {
      switch self {
      case .xl, .large: return Spacing.baseHorizontal
      case .regular: return Spacing.baseHorizontal
      case .small: return Spacing.halfHorizontal
      case .xs: return Spacing.quarterHorizontal
      }
    }
  }
}
