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
public struct TUIInputField: TUIInputFieldProtocol {
  
  @Binding var inputItem: TUIInputFieldItem
  public var rightButtonAction: (() -> Void)?
  
  @Binding var isTextFieldEditingOn: Bool
  private var isTextFieldFocused: Bool
  
  /* Facing some weird issue. When input item value is changed,
   it is getting updates in `TUIInputTextContentView` but not here.
   If I declare this variable, just declaration solves the problem
   */
  @FocusState private var isFocused: Bool
  
  public var properties: TUIInputFieldOptionalProperties
  public var currentTextFieldState: TUIInputFieldState

  private var maxCharacters: Int
  private var allowedCharacters: CharacterSet
  private var keyboardType: UIKeyboardType
  private var isTextField: Bool
  private var action: (() -> Void)?

  /// Creates a `TUIInputField` View
  /// - Parameters:
  ///   - properties: An `TUIInputFieldOptionalProperties` object that holds the optional values to create multiple variants of this View
  ///   - isTextFieldFocused: A bindable bool value that used to handle text field focus using keyboard
  ///   
  public init(inputItem: Binding<TUIInputFieldItem>,
              properties: TUIInputFieldOptionalProperties? = nil,
              currentTextFieldState: TUIInputFieldState = .none,
              isTextFieldFocused: Bool? = nil,
              isTextFieldEditingOn: Binding<Bool>? = nil,
              maxCharacters: Int = 0,
              allowedCharacters: CharacterSet = .init(),
              keyboardType: UIKeyboardType = .default,
              isTextField: Bool = false,
              action: (() -> Void)? = nil,
              rightButtonAction: (() -> Void)? = nil) {
    
    self._inputItem = inputItem
    self._isTextFieldEditingOn = isTextFieldEditingOn ?? Binding.constant(false)
    self.properties = properties ?? TUIInputFieldOptionalProperties()
    self.currentTextFieldState = currentTextFieldState
    self.maxCharacters = maxCharacters
    self.allowedCharacters = allowedCharacters
    self.keyboardType = keyboardType
    self.isTextFieldFocused = isTextFieldFocused ?? false
    self.isTextField = isTextField
    self.action = action
    self.rightButtonAction = rightButtonAction
  }
  
  public var body: some View {
    
    VStack(spacing: Spacing.halfVertical) {
      
      fieldBody
        .background(Color.inputBackground)
        .cornerRadius(8)
      
      let helperText = currentTextFieldState.helperText() ?? properties.state.helperText() ?? properties.helperText
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
      
      let highlightBar = currentTextFieldState.highlightBarColor ?? properties.state.highlightBarColor ?? properties.highlightBarColor
      
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
          
      textItem
        .frame(maxWidth: .infinity, alignment: .leading)

      endItem
        .frame(alignment: .trailing)
    }
    .padding(.horizontal, Spacing.baseHorizontal)
    .padding(.vertical, fieldBodyHStackVerticalPadding)
    .frame(minHeight: fieldBodyHeight, alignment: .top)
  }
  
  @ViewBuilder
  var textItem: some View {
    
    let textItem = TUIInputTextContentView(
      inputItem: $inputItem,
      placeholder: properties.placeholder,
      isTextFieldEditingOn: $isTextFieldEditingOn,
      maxCharacters: maxCharacters,
      allowedCharacters: allowedCharacters,
      keyboardType: keyboardType,
      isTextFieldFocused: isTextFieldFocused,
      isTextField: isTextField)
    
    if !self.isTextFieldFocused, let action {
      Button(action: action) {
        textItem
      }
    } else {
      textItem
    }
  }

  @ViewBuilder
  var endItem: some View {
    
    if let endItemStyle  = properties.endItemStyle {
      let endItem = TUIInputAdditionalView(
        style: endItemStyle, hasTitleAndValue: inputItem.hasTitleAndValue)
      
      if let rightButtonAction = rightButtonAction ?? action {
        Button(action: rightButtonAction) {
          endItem
        }
      } else {
        endItem
      }
    }
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

