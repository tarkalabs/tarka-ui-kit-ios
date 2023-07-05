//
//  TUIInputField.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI

struct TUIInputField: TUIInputFieldProtocol {

  @EnvironmentObject public var inputItem: TUIInputFieldItem
  
  var startItemStyle: TUIInputAdditionalView.Style?
  var endItemStyle: TUIInputAdditionalView.Style?
  
  var showHighlightBar = false
  var helperText: TUIHelperText?
  
  @Binding public var isTextFieldFocused: Bool

  init(isTextFieldFocused: Binding<Bool>? = nil) {
    self._isTextFieldFocused = isTextFieldFocused ?? Binding<Bool>.constant(false)
  }
  var body: some View {
    
    mainBody
  }
  
  @ViewBuilder
  private var mainBody: some View {
    VStack(spacing: Spacing.halfVertical) {
      
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
    
    HStack(alignment: .top, spacing: Spacing.halfHorizontal) {
      
      if let startItemStyle {
        TUIInputAdditionalView(
          style: startItemStyle, hasContent: inputItem.hasContent)
          .frame(alignment: .leading)
      }
      TUIInputTextContent(
        inputItem: inputItem, isTextFieldFocused: $isTextFieldFocused)
        .frame(maxWidth: .infinity, alignment: .leading)

      if let endItemStyle {
        TUIInputAdditionalView(
          style: endItemStyle, hasContent: inputItem.hasContent)
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
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Label"))

          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Label"))

          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Label"))

          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Label"))
        }
      }
      
      VStack(spacing: 20) {
        Group {
          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .text("$"))
            .highlightBar()
            .helperText {
              TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
            }
            .environmentObject(TUIInputFieldItem(style: .titleWithValue, title: "Label", value: "Input Text"))

          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .titleWithValue, title: "Label", value: "Input Text"))

          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .titleWithValue, title: "Label", value: "Input Text"))

          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .titleWithValue, title: "Label", value: "Input Text"))
        }
      }
      
      VStack(spacing: 20) {
        Group {
          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .text("$"))
            .highlightBar()
            .helperText {
              TUIHelperText(style: .hint, message: "Helper / hint message goes here.")
            }
            .environmentObject(TUIInputFieldItem(style: .onlyValue, value: "Input Text"))

          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .onlyValue, value: "Input Text"))

          TUIInputField()
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(Symbol.info))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .onlyValue, value: "Input Text"))

          TUIInputField()
            .startItem(withStyle: .icon(Symbol.info))
            .endItem(withStyle: .text("$"))
            .highlightBar()
            .environmentObject(TUIInputFieldItem(style: .onlyValue, value: "Input Text"))
        }
      }
    }.padding(.horizontal, 10)
  }
}

