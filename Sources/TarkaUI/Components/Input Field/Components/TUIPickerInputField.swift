//
//  TUIPickerInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

/// This is a SwiftUI View that uses a `TUIInputField` View and acts as Picker Input Field View which presents any other View and takes input from it.
/// It wraps all the Input data flow and styles within it.
///
/// It conforms to the same protocol `TUIInputFieldProtocol` that `TUIInputField` conformed and
/// holds all the same properties, variables and public functions that `TUIInputField` View have.
///
public struct TUIPickerInputField<Content: View>: TUIInputFieldProtocol {
  
  public var properties = TUIInputFieldOptionalProperties()
  private var content: Content
  @State private var isSheetPresented = false
  @Binding private var inputItem: TUIInputFieldItem
  
  /// Creates a`TUIPickerInputField` View
  /// - Parameters:
  ///   - inputItem: TUIInputItem's instance that holds the required values to render `TUIInputField` View
  ///   - Parameter content: A View that to be presented
  ///   
  public init(
    inputItem: Binding<TUIInputFieldItem>,
    @ViewBuilder _ content: @escaping () -> Content) {
      
      self._inputItem = inputItem
      self.content = content()
  }
  
  public var body: some View {
    
    TUIInputField(inputItem: $inputItem, properties: properties) {
      self.isSheetPresented = true
    }
    .sheet(
      isPresented: $isSheetPresented,
      content: {
        content
      })
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIPickerInputField {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIPickerInputField"
  }
}

struct TUIPickerInputField_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @State var item = TUIInputFieldItem(style: .onlyTitle, title: "Pick value")
    
    TUIPickerInputField(inputItem: $item) {
      TUITextRow("Test row", style: .onlyTitle)
    }
    .endItem(withStyle: .icon(.info24Regular))
 }
}
