//
//  TUIPickerInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

/// This is a SwiftUI View that uses a `TUIInputField` and acts as Picker Input Field view which presents any other view and takes input from it.
/// It wraps all the Input data flow and styles within it.
///
/// It conforms to the same protocol `TUIInputFieldProtocol` that `TUIInputField` conformed and
/// holds all the same properties, variables and public functions that `TUIInputField` have.
///
public struct TUIPickerInputField<Content: View>: TUIInputFieldProtocol {
  
  public var properties: TUIInputFieldOptionalProperties = TUIInputFieldOptionalProperties()
  private var content: Content
  
  @State private var isSheetPresented = false
  
  public init(@ViewBuilder _ content: @escaping () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
    
    Button(action: {
      self.isSheetPresented = true
    }) {
      TUIInputField(properties: properties)
        .sheet(
          isPresented: $isSheetPresented,
          content: {
            content
          })
    }
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
    
    TUIPickerInputField()
          {
            TUITextRow("Test row", style: .onlyTitle)
          }
          .endItem(withStyle: .icon(Symbol.info))
          .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "Pick value"))
  }
}
