//
//  TUIDateInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

/// This is a SwiftUI View that uses a `TUIInputField` and acts as Date Picker Input Field View which presents `TUIDatePopover` view and takes date input from it.
/// It wraps all the Input data flow and styles within it.
///
/// It conforms to the same protocol `TUIInputFieldProtocol` that `TUIInputField` View conformed and
/// holds all the same properties, variables and public functions that `TUIInputField` View have.
/// 
public struct TUIDateInputField: TUIInputFieldProtocol {
  
  @EnvironmentObject var inputItem: TUIInputFieldItem
  
  public var properties = TUIInputFieldOptionalProperties()
  
  @State private var isSheetPresented = false
  @State private var isDateSelected = false
  @State private var date = Date()
  
  private var defaultDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateFormat = "d MMM yyyy HH:mma"
    return dateFormatter
  }()
  
  private var dateFormatter: DateFormatter
  
  
  /// initializes with date formatter
  /// - Parameter dateFormatter: DateFormatter used to define how we are gonna display the date string.
  /// If we don't pass formatter, it picks the default value.
  /// Default formatter is `"d MMM yyyy HH:mma"`.
  /// Example result is`"6 Aug 2022 3:11PM"`
  public init(dateFormatter: DateFormatter? = nil) {
    self.dateFormatter = dateFormatter ?? defaultDateFormatter
  }
  
  public var body: some View {
    
    Button(action: {
      var date = Date()
      let value = inputItem.value
      if !value.isEmpty {
        let formattedDate = dateFormatter.date(from: value)
        date = formattedDate ?? Date()
      }
      self.isDateSelected = false
      self.date = date
      self.isSheetPresented = true    }) {
        TUIInputField(properties: properties)
          .onChange(of: isDateSelected) { newValue in
            
            self.inputItem.style = .titleWithValue
            let newDate = dateFormatter.string(from: date)
            self.inputItem.value = newDate
          }
          .onChange(of: date) { _ in }
        
          .sheet(
            isPresented: $isSheetPresented,
            content: {
              TUIDatePopover(date: $date, isShowing: $isSheetPresented, isSelected: $isDateSelected)
                .background(BackgroundClearView())
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
      .environmentObject(
        TUIInputFieldItem(style: .onlyTitle, title: "StartDate"))
  }
}
