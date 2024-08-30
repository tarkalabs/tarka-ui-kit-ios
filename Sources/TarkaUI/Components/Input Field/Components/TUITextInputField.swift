//
//  TUITextInputField.swift
//
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

/// This is a SwiftUI View that uses a `TUIInputField` and acts as Text Input Field View which takes text as input using keyboard.
/// It wraps all the Text Input data flow and styles within it.
///
/// It conforms to the same protocol `TUIInputFieldProtocol` that `TUIInputField` View conformed and
/// holds all the same properties, variables and public functions that `TUIInputField` View have.
///
public struct TUITextInputField: TUIInputFieldProtocol {
  
  public var properties = TUIInputFieldOptionalProperties()
  public var rightButtonAction: (() -> Void)?

  public var maxCharacters: Int = 0
  public var allowedCharacters = CharacterSet()
  public var keyboardType: UIKeyboardType = .default

  // Used to configure the secure field
  private var isSecureField: Bool

  /// Binds the bool that used to handle the row interaction and text field interaction switch when user interacts
  
  // Used to observe the field's focused state from the caller
  @Binding var isObservableFocused: Bool
  // Used to hold the field's focused state internally
  @State var isFocused: Bool = false
  @State var isEditingOn = false

  // Used to receive events when done button clicked
  @Binding private var dismissTextFocus: Bool

  @Binding private var inputItem: TUIInputFieldItem

  /// Creates a `TUITextInputField` view
  /// - Parameters:
  ///   - inputItem: TUIInputItem's instance that holds the required values to render `TUIInputField` View
  ///   - dismissTextFocus: Holds the field's focused state
  public init(
    inputItem: Binding<TUIInputFieldItem>,
    dismissTextFocus: Binding<Bool> = .constant(true),
    isFocused isObservableFocused: Binding<Bool> = .constant(false),
    isSecureField: Bool = false) {

      self._inputItem = inputItem
      self._dismissTextFocus = dismissTextFocus
      self._isObservableFocused = isObservableFocused
      self.isSecureField = isSecureField
    }
  
  public var body: some View {
    mainBody
      .onChange(of: dismissTextFocus, perform: { value in
        if value {
          isFocused = false
          removeWhiteSpaces()
          resetStyle()
        }
      })
      .onChange(of: isFocused, perform: { value in
        if !isFocused {
          // revert the dismissTextFocus to receive updates at `onChange`
          dismissTextFocus = false
        }
        isObservableFocused = isFocused
      })
      .onChange(of: isEditingOn, perform: { value in
        // used when switching between text fields
        if !value {
          removeWhiteSpaces()
          resetStyle()
        }
      })
      .onChange(of: inputItem.value) { _ in
        resetStyle()
      }
  }
  
  func resetStyle() {
    // revert the style when content is empty and lost focus
    if !isFocused, self.inputItem.value.isEmpty {
      self.inputItem.style = .onlyTitle
    }
  }
  @ViewBuilder
  private var mainBody: some View {
    inputFieldView
      .accessibilityIdentifier(Accessibility.root)
  }
  
  private var inputFieldView: some View {
    
    TUIInputField(
      inputItem: $inputItem,
      properties: properties,
      isTextFieldFocused: $isFocused,
      isTextFieldEditingOn: $isEditingOn,
      maxCharacters: maxCharacters,
      allowedCharacters: allowedCharacters,
      keyboardType: keyboardType,
      isTextField: true,
      isSecureField: isSecureField,
      action: {
        self.isFocused = true
        // change style
        if self.inputItem.style == .onlyTitle {
          self.inputItem.style = .titleWithValue
        }
      }, rightButtonAction: rightButtonAction)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  private var existingStyle: TUIInputFieldStyle {
    guard inputItem.style == .titleWithValue else {
      return inputItem.style
    }
    return .onlyTitle
  }
  
  private func removeWhiteSpaces() {
    // Remove whitespaces and newlines
    inputItem.value = inputItem.value.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

extension TUITextInputField {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUITextInputField"
  }
}

struct TUITextInputField_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @State var item = TUIInputFieldItem(style: .onlyTitle, title: "Enter Memo")
    
    TUITextInputField(
      inputItem: $item)
    .state(.alert("Input values are sensitive"))
    .endItem(withStyle: .icon(.info24Regular))
  }
}
