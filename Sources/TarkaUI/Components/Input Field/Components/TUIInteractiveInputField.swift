//
//  TUIInteractiveInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

public struct TUIInteractiveInputField<Content: View>: TUIInputFieldProtocol {
  
  public var startItemStyle: TUIInputAdditionalView.Style?
  public var endItemStyle: TUIInputAdditionalView.Style?
  public var highlightBar: Color?
  public var helperText: TUIHelperText?
  
  var content: Content
  
  @State internal var isSheetPresented = false
  
  public init(@ViewBuilder _ content: @escaping () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
    
    Button(action: {
      self.isSheetPresented = true
    }) {
      TUIInputField()
        .sheet(
        isPresented: $isSheetPresented,
        content: {
          content
        })
    }
  }
}
