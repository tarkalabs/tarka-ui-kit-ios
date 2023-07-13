//
//  TUIButtonStyle.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public enum TUIButtonStyle: Identifiable, CaseIterable {
  public var id: String {
    UUID().uuidString
  }
  
  case primary, secondary, outlined, ghost, danger
  
  var backgroundColor: Color {
    switch self {
    case .primary: return .primaryTUI
    case .secondary: return .secondaryTUI
    case .outlined: return .white
    case .ghost: return .clear
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
