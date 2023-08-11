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
  
  public var maxCharacters: Int = 0
  public var allowedCharacters = CharacterSet()
  public var keyboardType: UIKeyboardType = .default

  /// Binds the bool that used to handle the row interaction and text field interaction switch when user interacts
  @Binding private var isDoneClicked: Bool
  
  @State private var isFocused: Bool = false
  
  @Binding private var inputItem: TUIInputFieldItem
  
  
  /// Creates a `TUITextInputField` view
  /// - Parameters:
  ///   - inputItem: TUIInputItem's instance that holds the required values to render `TUIInputField` View
  ///   - isDoneClicked: A bindable bool value that used to handle text field focus when done clicked in toolbar
  ///   
  public init(
    inputItem: Binding<TUIInputFieldItem>,
    isDoneClicked: Binding<Bool>) {
      
      self._inputItem = inputItem
      self._isDoneClicked = isDoneClicked
    }
  
  public var body: some View {
    mainBody
      .onChange(of: $isDoneClicked.wrappedValue, perform: { value in
        if value {
          isFocused = false
        }
      })
      .onChange(of: $isFocused.wrappedValue, perform: { value in
        if !value {
          isDoneClicked = false
          // revert the style when content is empty
          if self.inputItem.value.isEmpty {
            self.inputItem.style = existingStyle
          }
        }
      })
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
      maxCharacters: maxCharacters,
      allowedCharacters: allowedCharacters,
      keyboardType: keyboardType) {
        
        self.isFocused = true
        // change style
        if self.inputItem.style == .onlyTitle {
          self.inputItem.style = .titleWithValue
        }
      }
      .accessibilityIdentifier(Accessibility.root)
  }
  
  private var existingStyle: TUIInputFieldStyle {
    guard inputItem.style == .titleWithValue else {
      return inputItem.style
    }
    return .onlyTitle
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
      inputItem: $item, isDoneClicked: Binding.constant(false))
    .state(.alert("Input values are sensitive"))
    .endItem(withStyle: .icon(.info24Regular))
  }
}
