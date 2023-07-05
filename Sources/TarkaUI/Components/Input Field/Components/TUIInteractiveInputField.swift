//
//  TUIInteractiveInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

public struct TUIInteractiveInputField<Content: View>: TUIInputFieldProtocol {
  
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
  
  var content: Content

  var inputFieldView: TUIInputField
  
  @State internal var isSheetPresented = false
  
  public init(inputItem: TUIInputFieldItem,
              @ViewBuilder _ content: @escaping () -> Content) {
    self.inputItem = inputItem
    self.inputFieldView = TUIInputField(inputItem: inputItem)
    self.content = content()
  }
  
  public var body: some View {
    
    Button(action: {
      self.isSheetPresented = true
    }) {
      inputFieldView
        .sheet(
        isPresented: $isSheetPresented,
        content: {
          content
        })
    }
  }
}
