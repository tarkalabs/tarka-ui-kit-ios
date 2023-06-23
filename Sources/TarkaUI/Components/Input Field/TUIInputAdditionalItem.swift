//
//  TUIInputAdditionalItem.swift
//  
//
//  Created by Gopinath on 23/06/23.
//

import SwiftUI

struct TUIInputAdditionalItem: View {
  
  
  enum Style {
    case text(String)
    case icon(Icon)
    case button(Icon, color: Color?, action: () -> Void)
  }
  
  var style: Style
  var config: TUIInputFieldConfig

  init(style: Style, config: TUIInputFieldConfig) {
    self.style = style
    self.config = config
  }
  
  var body: some View {
    
    switch style {
    case .text(let text):
      Text(text)
        .font(.body5)
        .foregroundColor(.inputTextDim)
        .frame(minHeight: 22)
        .padding(.top, textItemTopPadding)
      //        .accessibilityIdentifier(Accessibility.title)
      
    case .icon(let icon):
      Image(icon)
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
        .foregroundColor(.inputText)
        .padding(.horizontal, Spacing.custom(2.0))
        .padding(.top, iconItemTop + 1)
        .padding(.bottom, 1)
      
    case .button(let icon, let color, let action):
      Button(action: action) {
        Image(icon)
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
          .padding(.all, Spacing.custom(4.0))
          .foregroundColor(.white)
          .background(Color.primaryTUI)
      }
    }
  }
  
  var textItemTopPadding: CGFloat {
    switch config {
    case .onlyTitle(_):
      return 0
    default:
      return 14
    }
  }
  
  var iconItemTop: CGFloat {
    
    switch config {
    case .onlyTitle(_):
      return 0
    default:
      return 6
    }
  }
}

struct TUIInputAdditionalItem_Previews: PreviewProvider {
  static var previews: some View {
    HStack(spacing: 10) {
      TUIInputAdditionalItem(style: .text("$"), config: .onlyTitle("Label"))
      
      TUIInputAdditionalItem(style: .text("$"), config: .onlyValue("Label"))
      
      TUIInputAdditionalItem(style: .icon(Symbol.info), config: .onlyTitle("Label"))
      
      TUIInputAdditionalItem(style: .icon(Symbol.info), config: .onlyValue("Label"))
      
      TUIInputAdditionalItem(style: .button(Symbol.error, color: nil, action: { }), config: .onlyValue("Label"))
    }
  }
}
