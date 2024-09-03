//
//  TUIHelperText.swift
//  
//
//  Created by Gopinath on 23/06/23.
//

import SwiftUI

/// This is a SwiftUI View that displays helper text with icon in a horizontal stack.
/// The view can be customized with different styles, such as error, success, warning or just hint.
///
public struct TUIHelperText: View {
  
  private var style: Style
  private var showIcon: Bool
  private var message: String
  
  /// Creates a `TUIHelperText` View
  /// - Parameters:
  ///   - style: A style that defines a `TUIHelperText` View to render
  ///   - message: A string that to be displayed as a message
  ///   - showIcon: A bool value that decides whether the icon has to be shown or not
  ///
  public init(style: Style,
       message: String,
       showIcon: Bool = true) {
    
    self.style = style
    self.showIcon = showIcon
    self.message = message
  }
  
  public var body: some View {
    
    HStack(spacing: Spacing.quarterHorizontal) {
      if let icon = style.icon, showIcon {
        Image(fluent: icon)
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
  
  public enum Style {
    case error, success, warning, hint
    
    var icon: FluentIcon? {
      switch self {
      case .error: return .errorCircle24Filled
      case .success: return .checkmarkCircle16Regular
      case .warning: return .warning28Filled
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
