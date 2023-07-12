//
//  TUIInputAdditionalView.swift
//  
//
//  Created by Gopinath on 23/06/23.
//

import SwiftUI


/// This is a SwiftUI View that displays text or image in left or right side of the `TUIInputField` View
/// 
public struct TUIInputAdditionalView: View {
  
  public enum Style {
    case text(String)
    case icon(FluentIcon)
  }
  
  private var style: Style
  private var hasTitleAndValue: Bool
  
  /// Creates a `TUIInputAdditionalView` View
  /// - Parameters:
  ///   - style: A style that defines a `TUIInputTextContentView` View to render
  ///   - hasTitleAndValue: A bool value that tells it has both title and value.
  ///   It is used to match the top padding difference that caused by fluent icons.
  ///   
  init(style: Style, hasTitleAndValue: Bool) {
    self.style = style
    self.hasTitleAndValue = hasTitleAndValue
  }
  
  public var body: some View {
    
    switch style {
    case .text(let text):
      Text(text)
        .font(.body5)
        .foregroundColor(.inputTextDim)
        .frame(minHeight: 22)
        .padding(.top, textItemTopPadding + extraPadding)
        .accessibilityIdentifier(Accessibility.label)
      
    case .icon(let icon):
      Image(fluent: icon)
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
        .foregroundColor(.inputText)
        .padding(.horizontal, Spacing.custom(2.0))
        .padding(.top, iconItemTop + extraPadding) // fluent font size mismatch
        .padding(.bottom, 1)
        .accessibilityIdentifier(Accessibility.icon)
    }
  }
  
  var textItemTopPadding: CGFloat {
    return hasTitleAndValue ? Spacing.custom(14) : 0
  }
  
  var iconItemTop: CGFloat {
    return hasTitleAndValue ? Spacing.custom(6) : 0
  }
  
  var extraPadding: CGFloat {
    return hasTitleAndValue ? 1 : 0
  }
}

extension TUIInputAdditionalView {
  enum Accessibility: String, TUIAccessibility {
    case icon = "Icon"
    case label = "Text"
  }
}

struct TUIInputAdditionalItem_Previews: PreviewProvider {
  
  static var previews: some View {
    HStack(spacing: 10) {
      TUIInputAdditionalView(style: .text("$"), hasTitleAndValue: false)
      TUIInputAdditionalView(style: .text("$"), hasTitleAndValue: true)
      TUIInputAdditionalView(style: .icon(.info24Regular), hasTitleAndValue: false)
      TUIInputAdditionalView(style: .icon(.info24Regular), hasTitleAndValue: true)
    }
  }
}
