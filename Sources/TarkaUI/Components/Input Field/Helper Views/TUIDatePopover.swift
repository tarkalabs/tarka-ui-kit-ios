//
//  TUIDatePopover.swift
//  
//
//  Created by Gopinath on 05/07/23.
//

import SwiftUI

/// This is the class that displays the `DatePicker` in a View so that we can present it wherever we required.
///
struct TUIDatePopover: View {
  
  @Binding private var date: Date
  @Binding private var isShowing: Bool
  @Binding private var isSelected: Bool
  @State private var storedDate: Date
  
  /// Creates a `TUIDatePopover` View
  /// - Parameters:
  ///   - date: A bindable date value that acts as output when selected
  ///   - isShowing: A bindable bool value that used to show or hide this View
  ///   - isSelected: A bindable bool value that used to notify when date is selected
  init(date: Binding<Date>,
       isShowing: Binding<Bool>,
       isSelected: Binding<Bool>) {
    
    self._date = date
    self._isShowing = isShowing
    self._isSelected = isSelected
    self._storedDate = State<Date>.init(initialValue: date.wrappedValue)
  }
  
  var body: some View {
    
    VStack(spacing: 0) {
      
      Button("Done") {
        self.date = storedDate
        isSelected = true
        isShowing = false
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
      .padding(.trailing, Spacing.custom(30))
      .accessibilityIdentifier(Accessibility.done)
      
      DatePicker("", selection: $storedDate, displayedComponents: [.date, .hourAndMinute])
        .datePickerStyle(.graphical)
        .padding(.all, Spacing.custom(20))
        .accessibilityIdentifier(Accessibility.datePicker)
    }
    .frame(width: 350, height: 500, alignment: .center)
    .background(.white)
    .cornerRadius(5.0)
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIDatePopover {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIDatePopover"
    case datePicker = "DatePicker"
    case done = "Done"
  }
}

struct DatePopover_Previews: PreviewProvider {
  static var previews: some View {
    TUIDatePopover(
      date: Binding.constant(Date()),
      isShowing: Binding.constant(true),
      isSelected: Binding.constant(false))
  }
}
