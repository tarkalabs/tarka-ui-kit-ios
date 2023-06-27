//
//  TUIInputField.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI

public struct TUIInputText: View {

  private var style: TUIInputFieldStyle
  
  public var startItemStyle: TUIInputAdditionalItem.Style?
  public var endItemStyle: TUIInputAdditionalItem.Style?
  
  public var showHighlightBar = false
  public var helperText: TUIHelperText?

  public init(style: TUIInputFieldStyle) {
    self.style = style
  }
  public var body: some View {
    
    VStack(spacing: 4) {
      
      fieldBody
        .background(Color.inputBackground)
        .cornerRadius(8)
      
      if let helperText {
        helperText
      }
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var fieldBody: some View {
    VStack(spacing: 0) {
      
      fieldBodyHeaderHStack
      
      if showHighlightBar {
        Color.primaryTUI.frame(height: 2)
          .accessibilityIdentifier(Accessibility.highLightBar)
      }
    }
  }

  @ViewBuilder
  private var fieldBodyHeaderHStack: some View {
    
    HStack(alignment: .top, spacing: 8) {
      
      if let startItemStyle {
        TUIInputAdditionalItem(
          style: startItemStyle, hasContent: hasContent)
          .frame(alignment: .leading)
          .padding(.leading, 16)
      }
      TUIInputTextContent(style: style)
        .frame(maxWidth: .infinity, alignment: .leading)

      if let endItemStyle {
        TUIInputAdditionalItem(
          style: endItemStyle, hasContent: hasContent)
          .frame(alignment: .trailing)
          .padding(.trailing, 16)
      }
    }
    .padding(.top, fieldBodyHStackTopPadding)
    .frame(minHeight: fieldBodyHeight, alignment: .top)
  }
}

// MARK: - Padding & Height
extension TUIInputText {
  
  var fieldBodyHStackTopPadding: CGFloat {
    switch style {
    case .onlyTitle:
      return 17
    case .titleWithValue:
      return 10
    case .onlyValue:
      return 13
    }
  }
  
  var fieldBodyHeight: CGFloat {
    switch style {
    case .onlyTitle:
      return 54
    case .titleWithValue:
      return 56
    case .onlyValue:
      return 46
    }
  }
  
  var hasContent: Bool {
    guard case .titleWithValue = style else { return false }
    return true
  }
}

extension TUIInputText {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIInputText"
    case highLightBar = "HighLightBar"
  }
}

// MARK: - Preview

struct TUIInputText_Previews: PreviewProvider {
  
  static var previews: some View {
    Group {
      
      VStack(spacing: 20) {
        Group {
          TUIInputText(style: .onlyTitle("Label"))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle:  .text("$"))
            .helperText {
              TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
            }
            .highlightBar()
          
          TUIInputText(style: .onlyTitle("Label"))
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
          
          TUIInputText(style: .onlyTitle("Label"))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
          
          TUIInputText(style: .onlyTitle("Label"))
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar()
        }
      }
      
      VStack(spacing: 20) {
        Group {
          TUIInputText(style: .titleWithValue(title: "Label", value: "Input Text"))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .text("$"))
            .highlightBar()
            .helperText {
              TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
            }
          
          TUIInputText(style: .titleWithValue(title: "Label", value: "Input Text"))
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
          
          TUIInputText(style: .titleWithValue(title: "Label", value: "Input Text"))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
          
          TUIInputText(style: .titleWithValue(title: "Label", value: "Input Text"))
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar()
        }
      }
      
      VStack(spacing: 20) {
        Group {
          TUIInputText(style: .onlyValue("Input Text"))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .text("$"))
            .highlightBar()
            .helperText {
              TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
            }
          
          TUIInputText(style: .onlyValue("Input Text"))
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
          
          TUIInputText(style: .onlyValue("Input Text"))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
          
          TUIInputText(style: .onlyValue("Input Text"))
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar()
        }
      }
    }.padding(.horizontal, 10)
  }
}

