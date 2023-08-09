//
//  TUIInputField.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI

/// `TUIInputField` is a SwiftUI view that displays title and an content input field in a vertical stack.
/// The view can be customized with different styles, such as displaying only the title or displaying both the title and content.
///
/// It has few modifiers to configure its properties
/// such as startItem, endItem, highlight bar, helper text, content placeholder and its state.
///
/// Please refer those functions in `TUIInputField+Modifiers.swift`
///
struct TUIInputField: TUIInputFieldProtocol {
  
  @Binding var inputItem: TUIInputFieldItem
  @Binding private var isTextFieldFocused: Bool
  
  var properties: TUIInputFieldOptionalProperties
  
  private var textLimit: Int = 0
  private  var allowedCharacters: String = ""
  private var keyboardType: UIKeyboardType
  private var action: (() -> Void)?

  /// Creates a `TUIInputField` View
  /// - Parameters:
  ///   - properties: An `TUIInputFieldOptionalProperties` object that holds the optional values to create multiple variants of this View
  ///   - isTextFieldFocused: A bindable bool value that used to handle text field focus using keyboard
  ///   
  init(inputItem: Binding<TUIInputFieldItem>,
       properties: TUIInputFieldOptionalProperties? = nil,
       isTextFieldFocused: Binding<Bool>? = nil,
       textLimit: Int = 0, allowedCharacters: String = "",
       keyboardType: UIKeyboardType = .default,
       action: (() -> Void)? = nil) {
    self._inputItem = inputItem
    self.properties = properties ?? TUIInputFieldOptionalProperties()
    self.textLimit = textLimit
    self.allowedCharacters = allowedCharacters
    self.keyboardType = keyboardType
    self._isTextFieldFocused = isTextFieldFocused ?? Binding<Bool>.constant(false)
    self.action = action
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
      
      if !self.isTextFieldFocused, let action {
        Button(action: action) {
          fieldBodyHeaderHStack
        }
        .frame(maxWidth: .infinity, alignment: .center)
      } else {
        fieldBodyHeaderHStack
      }
      
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
        inputItem: $inputItem,
        placeholder: properties.placeholder,
        textLimit: textLimit, allowedCharacters: allowedCharacters,
        keyboardType: keyboardType,
        isTextFieldFocused: $isTextFieldFocused)
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
    case .onlyTitle: return 54
    case .titleWithValue: return 56
    case .onlyValue: return 46
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
          TUIInputField(inputItem: .constant(TUIInputFieldItem(style: .onlyTitle, title: "Label")))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle:  .text("$"))
            .helperText {
              TUIHelperText(
                style: .hint, message: "Helper / hint message goes here.")
            }
            .highlightBar(color: Color.primaryTUI)
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(style: .onlyTitle, title: "Label")))
            .startItem(withStyle: .icon(.info24Regular))
            .endItem(withStyle: .icon(.info24Regular))
            .highlightBar(color: Color.primaryTUI)
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(style: .onlyTitle, title: "Label")))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(.info24Regular))
            .highlightBar(color: Color.primaryTUI)
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(style: .onlyTitle, title: "Label")))
            .startItem(withStyle: .icon(.info24Regular))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
        }
      }
      
      VStack(spacing: 20) {
        Group {
          TUIInputField(inputItem: .constant(TUIInputFieldItem(
            style: .titleWithValue,
            title: "Label", value: "Input Text")))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
            .helperText {
              TUIHelperText(
                style: .hint, message: "Helper / hint message goes here.")
            }
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(
            style: .titleWithValue,
            title: "Label", value: "Input Text")))
            .startItem(withStyle: .icon(.info24Regular))
            .endItem(withStyle: .icon(.info24Regular))
            .highlightBar(color: Color.primaryTUI)
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(
            style: .titleWithValue,
            title: "Label", value: "Input Text")))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(.info24Regular))
            .highlightBar(color: Color.primaryTUI)
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(
            style: .titleWithValue,
            title: "Label", value: "Input Text")))
            .startItem(withStyle: .icon(.info24Regular))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
        }
      }
      
      VStack(spacing: 20) {
        Group {
          TUIInputField(inputItem: .constant(TUIInputFieldItem(style: .onlyValue, value: "Input Text")))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
            .helperText {
              TUIHelperText(
                style: .hint, message: "Helper / hint message goes here.")
            }
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(style: .onlyValue, value: "Input Text")))
            .startItem(withStyle: .icon(.info24Regular))
            .endItem(withStyle: .icon(.info24Regular))
            .highlightBar(color: Color.primaryTUI)
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(style: .onlyValue, value: "Input Text")))
            .startItem(withStyle: .text("$"))
            .endItem(withStyle: .icon(.info24Regular))
            .highlightBar(color: Color.primaryTUI)
          
          TUIInputField(inputItem: .constant(TUIInputFieldItem(style: .onlyValue, value: "Input Text")))
            .startItem(withStyle: .icon(.info24Regular))
            .endItem(withStyle: .text("$"))
            .highlightBar(color: Color.primaryTUI)
        }
      }
    }.padding(.horizontal, 10)
  }
}

