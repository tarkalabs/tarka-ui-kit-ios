//
//  TUIButtonStyle.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public extension TUIButton {
  
  enum Style: Identifiable {
    
    case primary, secondary, outlined, ghost, danger,
         custom(InputStyle)
    
    public var id: String {
      UUID().uuidString
    }
    
    public var inputStyle: InputStyle {
      switch self {
      case .primary:
        return .init(.primaryTUI, foreground: .onPrimary, border: .clear)
      case .secondary:
        return .init(.secondaryTUI, foreground: .onSecondary, border: .clear)
      case .outlined:
        return .init(.surface, foreground: .onSurface, border: .onSurface)
      case .ghost:
        return .init(.surface, foreground: .onSurface, border: .clear)
      case .danger:
        return .init(.error, foreground: .onPrimary, border: .clear)
      case .custom(let item):
        return item
      }
    }
    
    func borderWidth(_ isPressed: Bool) -> CGFloat {
      switch self {
      case .primary, .secondary, .ghost, .danger, .custom:
        return inputStyle.borderWidth
      case .outlined:
        return isPressed ? 2 : inputStyle.borderWidth
      }
    }
    
    func borderColor(_ isPressed: Bool) -> Color {
      switch self {
      case .primary, .secondary, .ghost, .danger:
        return isPressed ? .onSurface : .clear
      case .outlined:
        return .onSurface
      case .custom(let item):
        return isPressed ? item.foreground : item.border
      }
    }
  }
  
  struct InputStyle {
    var background: Color
    var foreground: Color
    var border: Color
    var borderWidth: CGFloat
    
    public init(_ background: Color, foreground: Color, border: Color, borderWidth: CGFloat = 1.5) {
      self.background = background
      self.foreground = foreground
      self.border = border
      self.borderWidth = borderWidth
    }
  }
}
