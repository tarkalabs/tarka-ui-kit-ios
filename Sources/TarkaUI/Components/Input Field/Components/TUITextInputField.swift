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
  
  @EnvironmentObject var inputItem: TUIInputFieldItem
  
  public var properties = TUIInputFieldOptionalProperties()
  
  /// Binds the bool that used to handle the row interaction and text field interaction switch when user interacts
  @State private var isTextFieldInteractive: Bool = false
  @Binding private var isTextFieldFocused: Bool
  
  /// Creates a `TUITextInputField` view
  /// - Parameter isTextFieldFocused: A bindable bool value that used to handle text field focus using keyboard
  public init(isTextFieldFocused: Binding<Bool>) {
    
    self._isTextFieldFocused = isTextFieldFocused
  }
  
  public var body: some View {
    mainBody
      .onChange(of: $isTextFieldFocused.wrappedValue, perform: { value in
        if !isTextFieldFocused {
          self.isTextFieldInteractive = false
          // revert the style when content is empty
          if self.inputItem.value.isEmpty {
            self.inputItem.style = existingStyle
          }
        }
      })
  }
  
  @ViewBuilder
  private var mainBody: some View {
    
    if !self.isTextFieldInteractive {
      
      Button(action: {
        // change style
        if self.inputItem.style == .onlyTitle {
          self.inputItem.style = .titleWithValue
        }
        self.isTextFieldFocused = true
        self.isTextFieldInteractive = true
      }) {
        inputFieldView
      }
      .accessibilityIdentifier(Accessibility.button)
    } else {
      inputFieldView
    }
  }
  
  private var inputFieldView: some View {
    TUIInputField(
      properties: properties,
      isTextFieldInteractive: $isTextFieldFocused,
      isTextFieldFocused: $isTextFieldFocused)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  private var existingStyle: TUIInputFieldItem.InputFieldStyle {
    guard inputItem.style == .titleWithValue else {
      return inputItem.style
    }
    return .onlyTitle
  }
}

extension TUITextInputField {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUITextInputField"
    case button = "TUITextInputField Row Button"
  }
}

struct TUITextInputField_Previews: PreviewProvider {
  
  static var previews: some View {
    
    TUITextInputField(isTextFieldFocused: Binding.constant(false))
      .state(.alert("Input values are sensitive"))
      .endItem(withStyle: .icon(Symbol.info))
      .environmentObject(
        TUIInputFieldItem(style: .onlyTitle, title: "Enter Memo"))
  }
}
