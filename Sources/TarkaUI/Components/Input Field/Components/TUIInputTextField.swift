//
//  TUIInputTextField.swift
//
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI


public struct TUIInputTextField: TUIInputFieldProtocol {
  
  @ObservedObject public var inputItem: TUIInputFieldItem
  
  public var startItemStyle: TUIInputAdditionalView.Style? {
    didSet {
      inputFieldView.startItemStyle = startItemStyle
    }
  }
  public var endItemStyle: TUIInputAdditionalView.Style? {
    didSet {
      inputFieldView.endItemStyle = endItemStyle
    }
  }
  public var showHighlightBar = false {
    didSet {
      inputFieldView.showHighlightBar = showHighlightBar
    }
  }
  public var helperText: TUIHelperText? {
    didSet {
      inputFieldView.helperText = helperText
    }
  }
  
  @Binding public var isTextFieldFocused: Bool

  var inputFieldView: TUIInputField
  
  private var existingStyle: TUIInputFieldItem.InputFieldStyle
    
  public init(inputItem: TUIInputFieldItem, isTextFieldFocused: Binding<Bool>) {
    
    self.inputItem = inputItem
    self.inputFieldView = TUIInputField(
      inputItem: inputItem, isTextFieldFocused: isTextFieldFocused)
    self.existingStyle = inputItem.style
    self._isTextFieldFocused = isTextFieldFocused
  }
  
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
        inputFieldView
      }
    } else {
      inputFieldView
    }
  }
}

