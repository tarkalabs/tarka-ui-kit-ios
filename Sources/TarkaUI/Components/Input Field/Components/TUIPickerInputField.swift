//
//  TUIPickerInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

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
