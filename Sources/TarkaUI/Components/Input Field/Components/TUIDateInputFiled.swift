//
//  TUIDateInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

/// This is a SwiftUI View that uses a `TUIInputField` and acts as Date Picker Input Field view which presents `TUIDatePopover` view and takes date input from it.
/// It wraps all the Input data flow and styles within it.
///
/// It conforms to the same protocol `TUIInputFieldProtocol` that `TUIInputField` conformed and
/// holds all the same properties, variables and public functions that `TUIInputField` have.
/// 
public struct TUIDateInputField: TUIInputFieldProtocol {
  
  @EnvironmentObject var inputItem: TUIInputFieldItem
  
  public var properties: TUIInputFieldOptionalProperties = TUIInputFieldOptionalProperties()
  
  @State private var isSheetPresented = false
  @State private var isDateSelected = false
  @State private var date = Date()
  
  public init() { }
  
  public var body: some View {
    
    Button(action: {
      self.isSheetPresented = true
    }) {
      TUIInputField(properties: properties)
        .onChange(of: isDateSelected) { _ in
          self.inputItem.style = .titleWithValue
          self.inputItem.value = date.description
        }
      // TODO: @Gopi, need to decide about the presentation
      //        .popover(isPresented: $isSheetPresented) {
      //        .fullScreenCover(
      //          isPresented: $isSheetPresented) {
        .sheet(
          isPresented: $isSheetPresented,
          content: {
            TUIDatePopover(date: $date, isShowing: $isSheetPresented, isSelected: $isDateSelected)
              .background(BackgroundClearView())
              .presentationDetents([.fraction(0.9)])
          })
    }
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIDateInputField {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIDateInputField"
  }
}

struct TUIDateInputField_Previews: PreviewProvider {
  
  static var previews: some View {
    
    TUIDateInputField()
      .endItem(withStyle: .icon(Symbol.checkBoxChecked))
      .highlightBar(color: .red)
      .state(.success("Values are valid"))
      .environmentObject(TUIInputFieldItem(style: .onlyTitle, title: "StartDate"))
  }
}
