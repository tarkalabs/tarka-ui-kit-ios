//
//  TUIInputContent.swift
//  
//
//  Created by Gopinath on 27/06/23.
//

import SwiftUI

struct TUIInputTextContent: View {

  @ObservedObject var inputItem: TUIInputFieldItem
    
  var placeholder: String = ""
  
  @Binding private var isTextFieldFocused: Bool
  @FocusState private var isFocused: Bool

  init(inputItem: TUIInputFieldItem, isTextFieldFocused: Binding<Bool>? = nil) {
    self.inputItem = inputItem
    self.placeholder = inputItem.title
    self._isTextFieldFocused = isTextFieldFocused ?? Binding<Bool>.constant(false)
  }
  
  var body: some View {
    
      VStack(spacing: Spacing.quarterVertical) {
        titleView
          .frame(maxWidth: .infinity, alignment: .leading)
        
        valueView
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .onAppear {
        if inputItem.isTextFieldInteractive {
            self.isFocused = true
        }
      }
      .onChange(of: $isFocused.wrappedValue, perform: { value in
        isTextFieldFocused = isFocused
      })
      .frame(minHeight: height)
      .accessibilityElement(children: .contain)
      .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var titleView: some View {
    
    let title = inputItem.title
      switch inputItem.style {
      case .onlyTitle:
        Text(title)
          .font(.body6)
          .foregroundColor(.inputTextDim)
          .frame(minHeight: 20)
          .frame(alignment: .leading)
          .accessibilityIdentifier(Accessibility.title)
        
      case .titleWithValue:
        Text(title)
          .font(.body8)
          .foregroundColor(.inputTextDim)
          .frame(minHeight: 14)
          .frame(alignment: .leading)
          .accessibilityIdentifier(Accessibility.title)
        
      case .onlyValue:
        EmptyView()
      }
  }
    
  @ViewBuilder
  private var valueView: some View {
    switch inputItem.style {
    case .onlyTitle:
      EmptyView()
      
    default:
      TextField(placeholder,
                text: $inputItem.value,
                axis: .vertical)
      .lineSpacing(0)
      .focused($isFocused)
      .multilineTextAlignment(.leading)
      .labelsHidden()
      .font(.body6)
      .foregroundColor(.inputText)
      .frame(minHeight: 20, alignment: .leading)
      .disabled(!inputItem.isTextFieldInteractive)
      .accessibilityIdentifier(Accessibility.value)
    }
  }
  
  var height: CGFloat {
    switch inputItem.style {
    case .onlyTitle:
      return 20
    case .titleWithValue:
      return 36
    case .onlyValue:
      return 20
    }
  }
}

extension TUIInputTextContent {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIInputTextContent"
    case title = "Title"
    case value = "Value"
  }
}

struct TUIInputTextContent_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 10) {
      Group {
        TUIInputTextContent(inputItem: .init(style: .onlyTitle, title: "Label"))
        TUIInputTextContent(inputItem: .init(style: .titleWithValue, title: "Label", value: "Description"))
        TUIInputTextContent(inputItem: .init(style: .onlyValue, value: "Description"))
      }.padding(.horizontal, 20)
    }
  }
}
