//
//  TUIInputAdditionalItem.swift
//  
//
//  Created by Gopinath on 23/06/23.
//

import SwiftUI

public struct TUIInputAdditionalItem: View {
  
  
  public enum Style {
    case text(String)
    case icon(Icon)
    case button(TUIIconButton)
  }
  
  var style: Style
  var hasContent: Bool

  init(style: Style, hasContent: Bool) {
    self.style = style
    self.hasContent = hasContent
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
      Image(icon)
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
        .foregroundColor(.inputText)
        .padding(.horizontal, Spacing.custom(2.0))
        .padding(.top, iconItemTop + extraPadding) // fluent font size mismatch
        .padding(.bottom, 1)
        .accessibilityIdentifier(Accessibility.icon)

    case .button(let iconButton):
      iconButton
    }
  }
  
  var textItemTopPadding: CGFloat {
    return hasContent ? 14 : 0
  }
  
  var iconItemTop: CGFloat {
    return hasContent ? 6 : 0
  }
  
  var extraPadding: CGFloat {
    return hasContent ? 1 : 0
  }
}

extension TUIInputAdditionalItem {
  enum Accessibility: String, TUIAccessibility {
    case icon = "TUIInputAdditionalIconItem"
    case label = "TUIInputAdditionaltextItem"
  }
}

struct TUIInputAdditionalItem_Previews: PreviewProvider {
  
  static var previews: some View {
    
    HStack(spacing: 10) {
      TUIInputAdditionalItem(style: .text("$"), hasContent: false)
      
      TUIInputAdditionalItem(style: .text("$"), hasContent: true)
      
      TUIInputAdditionalItem(style: .icon(Symbol.info), hasContent: false)
      
      TUIInputAdditionalItem(style: .icon(Symbol.info), hasContent: true)
      
      TUIInputAdditionalItem(
        style: .button(
          TUIIconButton(icon: Symbol.error, action: { })
            .size(.m)
            .style(.primary)
        ),
        hasContent: true)
    }
  }
}
