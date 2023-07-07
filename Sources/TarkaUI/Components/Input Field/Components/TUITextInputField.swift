//
//  TUITextInputField.swift
//
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

public struct TUITextInputField: TUIInputFieldProtocol {
  
  @EnvironmentObject var inputItem: TUIInputFieldItem
  
  public var properties: TUIInputFieldOptionalProperties = TUIInputFieldOptionalProperties()
  
  @Binding private var isTextFieldFocused: Bool
  
  public var body: some View {
    mainBody
      .onChange(of: $isTextFieldFocused.wrappedValue, perform: { value in
        if !isTextFieldFocused {
          self.inputItem.isTextFieldInteractive = false
          // revert the style when content is empty
          if self.inputItem.value.isEmpty {
            self.inputItem.style = existingStyle
          }
        }
      })
  }
  
  public init(isTextFieldFocused: Binding<Bool>) {
    
    self._isTextFieldFocused = isTextFieldFocused
  }
  
  @ViewBuilder
  private var mainBody: some View {
    
    if !self.inputItem.isTextFieldInteractive {
      
      Button(action: {
        // change style
        if self.inputItem.style == .onlyTitle {
          self.inputItem.style = .titleWithValue
        }
        self.isTextFieldFocused = true
        self.inputItem.isTextFieldInteractive = true
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
      properties: properties, isTextFieldFocused: $isTextFieldFocused)
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
