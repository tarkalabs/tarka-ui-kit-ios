//
//  TUIInputTextContentView.swift
//  
//
//  Created by Gopinath on 27/06/23.
//

import SwiftUI

/// This is SwiftUI View that displays title and text content for the `TUIInputField` view in the vertical stack.
/// The view can be customized with different styles,
/// such as displaying only the title or displaying both the title and content.
/// 
struct TUIInputTextContentView: View {
  
  @ObservedObject var inputItem: TUIInputFieldItem
  
  var placeholder: String
  
  @Binding private var isTextFieldFocused: Bool
  
  private var isTextFieldInteractive: Bool
  
  @FocusState private var isFocused: Bool
  
  init(inputItem: TUIInputFieldItem,
       isTextFieldInteractive: Bool = true,
       placeholder: String? = nil,
       isTextFieldFocused: Binding<Bool>? = nil) {
    
    self.inputItem = inputItem
    self.isTextFieldInteractive = isTextFieldInteractive
    self.placeholder = placeholder ?? ""
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
      if isTextFieldInteractive {
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
      .disabled(!isTextFieldInteractive)
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

extension TUIInputTextContentView {
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
        TUIInputTextContentView(inputItem: .init(style: .onlyTitle, title: "Label"))
        TUIInputTextContentView(inputItem: .init(style: .titleWithValue, title: "Label", value: "Description"))
        TUIInputTextContentView(inputItem: .init(style: .onlyValue, value: "Description"))
      }.padding(.horizontal, 20)
    }
  }
}
