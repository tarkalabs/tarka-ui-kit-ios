//
//  TUIDateInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

public struct TUIDateInputField: TUIInputFieldProtocol {
  
  @EnvironmentObject public var inputItem: TUIInputFieldItem

  public var properties: TUIInputFieldProperties = TUIInputFieldProperties()

  @State internal var isSheetPresented = false
  @State internal var date = Date()
  
  public init() { }
    
  public var body: some View {
    
    Button(action: {
      self.isSheetPresented = true
    }) {
      TUIInputField(properties: properties)
        .onChange(of: date) { newValue in
          self.inputItem.style = .titleWithValue
          self.inputItem.value = newValue.description
        }
      // TODO: @Gopi, need to decide about the presentation
//        .popover(isPresented: $isSheetPresented) {
//        .fullScreenCover(
//          isPresented: $isSheetPresented) {
        .sheet(
        isPresented: $isSheetPresented,
        content: {
          TUIDatePopover(date: $date, isShowing: $isSheetPresented)
            .background(BackgroundClearView())
            .presentationDetents([.fraction(0.9)])
        })
    }
  }
}
