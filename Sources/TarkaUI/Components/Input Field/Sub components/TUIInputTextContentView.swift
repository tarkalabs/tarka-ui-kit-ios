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
  
  @Binding var inputItem: TUIInputFieldItem
  @Binding private var isTextFieldFocused: Bool
  @FocusState private var isFocused: Bool
  
  private var placeholder: String
  private var textLimit: Int = 0
  private var keyboardType: UIKeyboardType
  private var allowedCharacters: String = ""

  /// Creates a `TUIInputTextContentView` View
  /// - Parameters:
  ///   - inputItem: A `TUIInputFieldItem` instance that holds the required values to render `TUIInputTextContentView` View
  ///   - placeholder: A string that to be shown as placeholder for text content field
  ///   - isTextFieldFocused: A bindable bool value that handles text field keyboard focus
  ///   
  init(inputItem: Binding<TUIInputFieldItem>,
       placeholder: String? = nil,
       textLimit: Int = 0, allowedCharacters: String = "",
       keyboardType: UIKeyboardType = .default,
       isTextFieldFocused: Binding<Bool>? = nil) {
    
    self._inputItem = inputItem
    self.placeholder = placeholder ?? ""
    self.textLimit = textLimit
    self.allowedCharacters = allowedCharacters
    self.keyboardType = keyboardType
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
      if isTextFieldFocused {
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
      .onChange(of: inputItem.value) { _ in
        limitText()
      }
      .keyboardType(keyboardType)
      .lineSpacing(0)
      .focused($isFocused)
      .multilineTextAlignment(.leading)
      .labelsHidden()
      .font(.body6)
      .foregroundColor(.inputText)
      .frame(minHeight: 20, alignment: .leading)
      .disabled(!isTextFieldFocused)
      .accessibilityIdentifier(Accessibility.value)
    }
  }
  
  private func limitText() {
    
    let count = inputItem.value.count
    
    if textLimit > 0, count > textLimit {
      inputItem.value = String(inputItem.value.prefix(textLimit))
      
    } else if !allowedCharacters.isEmpty {
      if keyboardType == .decimalPad {
        // restrict multiple dots
        let filtered = inputItem.value.filter { $0 == "." }
        if filtered.count > 1, let firstIndex = inputItem.value.firstIndex(of: ".") {
          inputItem.value.removeAll(where: { $0 == "." })
          inputItem.value.insert(".", at: firstIndex)
          return
        }
      }
      let filtered = inputItem.value.filter { allowedCharacters.contains($0) }
      if filtered != inputItem.value {
        inputItem.value = filtered
      }
    }
  }
  
  var height: CGFloat {
    switch inputItem.style {
    case .onlyTitle: return 20
    case .titleWithValue: return 36
    case .onlyValue: return 20
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
        TUIInputTextContentView(
          inputItem: .constant(.init(style: .onlyTitle, title: "Label")))
        
        TUIInputTextContentView(
          inputItem: .constant(.init(
            style: .titleWithValue, title: "Label", value: "Description")))
        
        TUIInputTextContentView(
          inputItem: .constant(.init(style: .onlyValue, value: "Description")))
      }
      .padding(.horizontal, 20)
    }
  }
}
