//
//  TUIInputTextContentView.swift
//  
//
//  Created by Gopinath on 27/06/23.
//

import SwiftUI
import Combine

/// This is SwiftUI View that displays title and text content for the `TUIInputField` view in the vertical stack.
/// The view can be customized with different styles,
/// such as displaying only the title or displaying both the title and content.
/// 
struct TUIInputTextContentView: View {
  
  @Binding var inputItem: TUIInputFieldItem
  
  @Binding private var isTextFieldFocused: Bool
  @FocusState private var isFocused: Bool
  @Binding var isTextFieldEditingOn: Bool

  private var placeholder: String
  private var maxCharacters: Int
  private var keyboardType: UIKeyboardType
  private var allowedCharacters: CharacterSet
  private var isTextField: Bool
  
  /// Creates a `TUIInputTextContentView` View
  /// - Parameters:
  ///   - inputItem: A `TUIInputFieldItem` instance that holds the required values to render `TUIInputTextContentView` View
  ///   - placeholder: A string that to be shown as placeholder for text content field
  ///   - isTextFieldFocused: A bindable bool value that handles text field keyboard focus
  ///
  init(inputItem: Binding<TUIInputFieldItem>,
       placeholder: String? = nil,
       isTextFieldEditingOn: Binding<Bool>? = nil,
       maxCharacters: Int = 0,
       allowedCharacters: CharacterSet = .init(),
       keyboardType: UIKeyboardType = .default,
       isTextFieldFocused: Binding<Bool> = .constant(false),
       isTextField: Bool = false) {
    
    self._inputItem = inputItem
    self.placeholder = placeholder ?? ""
    self.maxCharacters = maxCharacters
    self.allowedCharacters = allowedCharacters
    self.keyboardType = keyboardType
    self._isTextFieldFocused = isTextFieldFocused
    self.isTextField = isTextField
    self._isTextFieldEditingOn = isTextFieldEditingOn ?? Binding.constant(false)
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
      textView
        .font(.body6)
        .foregroundColor(.inputText)
        .frame(minHeight: 20, alignment: .leading)
        .accessibilityIdentifier(Accessibility.value)
    }
  }
  
  @State var textFieldChanges = false
  @ViewBuilder
  var textView: some View {
    if isTextField {
      TextField(placeholder,
                text: $inputItem.value,
                axis: .vertical)
      .textFieldStyle(.plain)
      .onChange(of: inputItem.value) { newValue in
        limitText(newValue)
      }
      .onChange(of: isFocused) { newValue in
        isTextFieldEditingOn = newValue
      }
      .keyboardType(keyboardType)
      .lineSpacing(0)
      .focused($isFocused)
      .multilineTextAlignment(.leading)
      .labelsHidden()
      .disabled(!isTextFieldFocused)
    } else {
      Text(inputItem.value)
    }
  }
  
  private func limitText(_ newValue: String) {
    var filteredText = newValue
    let count = filteredText.count
    
    if keyboardType == .decimalPad {
      // restrict multiple dots
      let dot: Character = "."
      let dotFiltered = filteredText.filter { $0 == dot }
      if dotFiltered.count > 1, let firstIndex = newValue.firstIndex(of: dot) {
        filteredText.removeAll(where: { $0 == dot })
        filteredText.insert(dot, at: firstIndex)
        inputItem.value = filteredText
        return
      }
    }
    if maxCharacters > 0, count > maxCharacters {
      // restrict count
      inputItem.value = String(filteredText.prefix(maxCharacters))
      return
    }
    
    if !allowedCharacters.isEmpty {
      // remove restricted characters
      let filtered = filteredText.filter { (c) -> Bool in
        return !c.unicodeScalars.allSatisfy { s in
          !allowedCharacters.contains(s)
        }
      }

      inputItem.value = filtered
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
