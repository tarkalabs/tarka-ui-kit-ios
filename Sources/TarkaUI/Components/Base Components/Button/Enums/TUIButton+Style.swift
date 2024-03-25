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
        return .init(background: .primaryTUI, foreground: .onPrimary)
      case .secondary:
        return .init(background: .secondaryTUI, foreground: .onSecondary)
      case .outlined:
        return .init(background: .surface, foreground: .onSurface, border: .onSurface)
      case .ghost:
        return .init(background: .surface, foreground: .onSurface)
      case .danger:
        return .init(background: .error, foreground: .onPrimary)
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
    
    public init(background: Color, foreground: Color, border: Color = .clear, borderWidth: CGFloat = 1.5) {
      self.background = background
      self.foreground = foreground
      self.border = border
      self.borderWidth = borderWidth
    }
  }
}
