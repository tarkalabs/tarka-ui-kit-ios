//
//  TUIHelperText.swift
//  
//
//  Created by Gopinath on 23/06/23.
//

import SwiftUI


struct TUIHelperText: View {
  
  enum Style {
    case error, success, warning, hint
    
    var icon: Icon? {
      switch self {
      case .error:
        return Symbol.error
      case .success:
        return Symbol.info
      case .warning:
        return Symbol.warning
      case .hint:
        return nil
      }
    }
    
    var iconColor: Color {
      switch self {
      case .error:
        return .error
      case .success:
        return .success
      case .warning:
        return .warning
      case .hint:
        return .clear
      }
    }
    
    var text: String {
      switch self {
      case .error:
        return "Error message goes here."
      case .success:
        return "Success message goes here."
      case .warning:
        return "Warning message goes here."
      case .hint:
        return "Helper / hint message goes here."
      }
    }
  }
  
  var style: Style
  
  init(style: Style) {
    self.style = style
  }
  
  var body: some View {
    
    HStack(spacing: 4) {
      if let icon = style.icon {
        Image(icon)
          .resizable()
          .scaledToFit()
          .frame(width: 16, height: 16)
          .foregroundColor(style.iconColor)
      }
      Text(style.text)
        .font(.body7)
        .foregroundColor(.inputText)
        .frame(minHeight: 22)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.leading, Spacing.custom(16))
  }
}

struct TUIHelperText_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 5) {
      TUIHelperText(style: .error)
      TUIHelperText(style: .success)
      TUIHelperText(style: .warning)
      TUIHelperText(style: .hint)
    }
  }
}
