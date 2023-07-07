//
//  TUIHelperText.swift
//  
//
//  Created by Gopinath on 23/06/23.
//

import SwiftUI


public struct TUIHelperText: View {
  
  public enum Style {
    case error, success, warning, hint
    
    var icon: Icon? {
      switch self {
      case .error: return Symbol.error
      case .success: return Symbol.success
      case .warning: return Symbol.warning
      case .hint: return nil
      }
    }
    
    var iconColor: Color {
      switch self {
      case .error: return .error
      case .success: return .success
      case .warning: return .warning
      case .hint: return .clear
      }
    }
  }
  
  var style: Style
  var showIcon: Bool
  var message: String
  
  init(style: Style,
       message: String,
       showIcon: Bool = true) {
    
    self.style = style
    self.showIcon = showIcon
    self.message = message
  }
  
  public var body: some View {
    
    HStack(spacing: Spacing.quarterHorizontal) {
      if let icon = style.icon, showIcon {
        Image(icon)
          .resizable()
          .scaledToFit()
          .frame(width: 16, height: 16)
          .foregroundColor(style.iconColor)
          .accessibilityIdentifier(Accessibility.icon)
      }
      Text(message)
        .font(.body7)
        .foregroundColor(.inputText)
        .frame(minHeight: 18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityIdentifier(Accessibility.label)
    }
    .padding(.horizontal, Spacing.baseHorizontal)
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIHelperText {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIHelperText"
    case icon = "Icon"
    case label = "Label"
  }
}

struct TUIHelperText_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 5) {
      TUIHelperText(style: .error, message: "Error message goes here.")
      TUIHelperText(style: .success, message: "Success message goes here.")
      TUIHelperText(style: .warning, message: "Warning message goes here.")
      TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
    }
  }
}
