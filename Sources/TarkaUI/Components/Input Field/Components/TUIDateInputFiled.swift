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
  
  public var properties = TUIInputFieldOptionalProperties()
  public var rightButtonAction: (() -> Void)?

  @State private var isSheetPresented = false
  @State private var isDateSelected = false
  @State private var date = Date()
  @State private var inputItem: TUIInputFieldItem
  @Binding private var dateInputItem: TUIDateInputFieldItem
  
  var minDate: Date?
  var maxDate: Date?
  
  /// Initializes with date input item
  /// - Parameter dateInputItem: TUIDateInputFieldItem instance that holds the style and date value.
  /// If we don't pass date, it picks the current date.
  /// Internally, this will be converted to `TUIInputFieldItem` instance
  /// and will be passed to `TUIInputFiled` as environmentObject
  ///
  public init(dateInputItem: Binding<TUIDateInputFieldItem>,
              minDate: Date? = nil,
              maxDate: Date? = nil) {
    
    let dateInputValue = dateInputItem.wrappedValue
    var inputItem = TUIInputFieldItem(
      style: dateInputValue.style, title: dateInputValue.title)
    
    if let dateValue = dateInputValue.date {
      inputItem.value = dateValue.formatted(dateInputValue.format)
      inputItem.style = .titleWithValue
    }
    self._dateInputItem = dateInputItem
    self._inputItem = State(initialValue: inputItem)
    
    self.minDate = minDate
    self.maxDate = maxDate
    
    _date = State(initialValue: dateToSet)
  }
  
  public var body: some View {
    
    TUIInputField(
      inputItem: $inputItem, properties: properties,
      action:  {
      self.date = dateInputItem.date ?? dateToSet
      self.isDateSelected = false
      self.isSheetPresented = true
    }, rightButtonAction: rightButtonAction)
    .onChange(of: isDateSelected) { newValue in
      
      self.inputItem.style = .titleWithValue
      let dateString = date.formatted(dateInputItem.format)
      self.inputItem.value = dateString
      self.dateInputItem.date = date
    }
    // without a below line of code, date can not receive updates. Weird one. For now, we go with this hack.
    .onChange(of: date) { _ in }
    .fullScreenCover(
      isPresented: $isSheetPresented,
      content: {
        TUIDatePopover(
          date: $date,
          isShowing: $isSheetPresented,
          isSelected: $isDateSelected,
          minDate: minDate,
          maxDate: maxDate
        )
        .blackOverlayBackground()
        .presentationDetents([.fraction(0.9)])
      })
    .accessibilityIdentifier(Accessibility.root)
  }
  
  private var dateToSet: Date {
    let currentDate = Date()
    if let minDate, currentDate < minDate {
      return minDate
    } else if let maxDate, currentDate > maxDate {
      return maxDate
    }
    
    return currentDate
  }
}

extension TUIDateInputField {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIDateInputField"
  }
}

struct TUIDateInputField_Previews: PreviewProvider {
  
  static var previews: some View {
    
    TUIDateInputField(
      dateInputItem: Binding.constant(TUIDateInputFieldItem(
        style: .onlyTitle, title: "StartDate",
        format: .init(date: .abbreviated, time: .standard))))
    .endItem(withStyle: .icon(.checkboxChecked24Filled))
    .highlightBar(color: .red)
    .state(.success("Values are valid"))
  }
}
