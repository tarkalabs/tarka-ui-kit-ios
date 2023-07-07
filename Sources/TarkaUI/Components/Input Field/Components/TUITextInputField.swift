//
//  TUITextInputField.swift
//
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI


public struct TUITextInputField: TUIInputFieldProtocol {
  
  @EnvironmentObject public var inputItem: TUIInputFieldItem
  
  public var properties: TUIInputFieldProperties = TUIInputFieldProperties()

  @Binding public var isTextFieldFocused: Bool
    
  public var body: some View {
    mainBody
      .onChange(of: $isTextFieldFocused.wrappedValue, perform: { value in
        if !isTextFieldFocused {
          self.inputItem.isTextFieldInteractive = false
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
  var mainBody: some View {
    
    if !self.inputItem.isTextFieldInteractive {
      
      Button(action: {
        // change style
        if self.inputItem.style == .onlyTitle {
          self.inputItem.style = .titleWithValue
        }
        self.isTextFieldFocused = true
        self.inputItem.isTextFieldInteractive = true
      }) {
        inputFiledView
      }
    } else {
      inputFiledView
    }
  }
  
  var inputFiledView: some View {
    TUIInputField(properties: properties,
                  isTextFieldFocused: $isTextFieldFocused)
  }
  
  var existingStyle: TUIInputFieldItem.InputFieldStyle {
    guard inputItem.style == .titleWithValue else {
      return inputItem.style
    }
    return .onlyTitle
  }
}

