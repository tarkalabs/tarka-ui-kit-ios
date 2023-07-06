//
//  TUIInteractiveInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

public struct TUIPickerInputField<Content: View>: TUIInputFieldProtocol {
  
  public var properties: TUIInputFieldProperties = TUIInputFieldProperties()
  var content: Content
  
  @State internal var isSheetPresented = false
  
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
  }
}
