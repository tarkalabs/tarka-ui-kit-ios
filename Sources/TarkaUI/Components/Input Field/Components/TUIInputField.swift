//
//  TUIInputField.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI

struct TUIInputField: TUIInputFieldProtocol {
  
  @EnvironmentObject var inputItem: TUIInputFieldItem
  
  @Binding var isTextFieldFocused: Bool
  
  var properties: TUIInputFieldOptionalProperties
  
  init(properties: TUIInputFieldOptionalProperties? = nil,
       state: TUIInputFieldState? = nil,
       isTextFieldFocused: Binding<Bool>? = nil) {
    
    self._isTextFieldFocused = isTextFieldFocused ?? Binding<Bool>.constant(false)
    self.properties = properties ?? TUIInputFieldOptionalProperties()
  }
  
  var body: some View {
    
    VStack(spacing: Spacing.halfVertical) {
      
      fieldBody
        .background(Color.inputBackground)
        .cornerRadius(8)
      
      let helperText = properties.state.helperText() ?? properties.helperText
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
      
      let highlightBar =  properties.state.highlightBarColor ?? properties.highlightBarColor
      
      if let highlightBar {
        highlightBar.frame(height: 2)
          .accessibilityIdentifier(Accessibility.highLightBar)
      }
    }
  }
  
  @ViewBuilder
  private var fieldBodyHeaderHStack: some View {
    
    HStack(alignment: .top, spacing: Spacing.halfHorizontal) {
      
      if let startItemStyle  = properties.startItemStyle {
        TUIInputAdditionalView(
          style: startItemStyle, hasTitleAndValue: inputItem.hasTitleAndValue)
        .frame(alignment: .leading)
      }
      TUIInputTextContentView(
        inputItem: inputItem,
        isTextFieldFocused: $isTextFieldFocused,
        placeholder: properties.placeholder)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      if let endItemStyle  = properties.endItemStyle {
        TUIInputAdditionalView(
          style: endItemStyle, hasTitleAndValue: inputItem.hasTitleAndValue)
        .frame(alignment: .trailing)
      }
    }
    .padding(.horizontal, Spacing.baseHorizontal)
    .padding(.vertical, fieldBodyHStackVerticalPadding)
    .frame(minHeight: fieldBodyHeight, alignment: .top)
  }
}


// MARK: - Padding & Height

extension TUIInputField {
  
  var fieldBodyHStackVerticalPadding: CGFloat {
    switch inputItem.style {
    case .onlyTitle:
      return Spacing.custom(17)
    case .titleWithValue:
      return Spacing.custom(10)
    case .onlyValue:
      return Spacing.custom(13)
    }
  }
  
  var fieldBodyHeight: CGFloat {
    switch inputItem.style {
    case .onlyTitle:
      return 54
    case .titleWithValue:
      return 56
    case .onlyValue:
      return 46
    }
  }
}

extension TUIInputField {
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
          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle:  .text("$"))
            .helperText {
              TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
            }
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Label"))
          
          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Label"))
          
          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Label"))
          
          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Label"))
        }
      }
      
      VStack(spacing: 20) {
        Group {
          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
            .helperText {
              TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
            }
            .environmentObject(TUIInputFieldItem(style: .titleWithValue, title: "Label", value: "Input Text"))
          
          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .titleWithValue, title: "Label", value: "Input Text"))
          
          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .titleWithValue, title: "Label", value: "Input Text"))
          
          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .titleWithValue, title: "Label", value: "Input Text"))
        }
      }
      
      VStack(spacing: 20) {
        Group {
          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
            .helperText {
              TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
            }
            .environmentObject(TUIInputFieldItem(style: .onlyValue, value: "Input Text"))
          
          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .onlyValue, value: "Input Text"))
          
          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .onlyValue, value: "Input Text"))
          
          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
            .environmentObject(TUIInputFieldItem(style: .onlyValue, value: "Input Text"))
        }
      }
    }.padding(.horizontal, 10)
  }
}

