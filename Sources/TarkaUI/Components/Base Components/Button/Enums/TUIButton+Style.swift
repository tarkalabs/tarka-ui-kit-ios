//
//  TUIButtonStyle.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public extension TUIButton {
  
  enum Style: Identifiable, CaseIterable {
    
    case primary, secondary, outlined, ghost, danger
    
    public var id: String {
      UUID().uuidString
    }
    
    var backgroundColor: Color {
      switch self {
      case .primary: return .primaryTUI
      case .secondary: return .secondaryTUI
      case .outlined: return .surface
      case .ghost: return .surface
      case .danger: return .error
      }
    }
    
    var foregroundColor: Color {
      switch self {
      case .primary: return .onPrimary
      case .secondary: return .onSecondary
      case .outlined: return .onSurface
      case .ghost: return .secondaryTUI
      case .danger: return .onPrimary
      }
    }
    
    var borderWidth: CGFloat {
      switch self {
      case .outlined: return 1.5
      default: return 0
      }
    }
  }
}
