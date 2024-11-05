//
//  TUIDatePopover.swift
//
//
//  Created by Gopinath on 05/07/23.
//

import SwiftUI

/// This is the class that displays the `DatePicker` in a View so that we can present it wherever we required.
///
public struct TUIDatePopover: View {
  
  @Binding private var date: Date?
  @Binding private var isShowing: Bool
  @Binding private var isSelected: Bool
  @State private var storedDate: Date
  var minDate: Date?
  var maxDate: Date?
  var showTime = true
  var displayComponents: DatePickerComponents = [.date, .hourAndMinute]
  
  /// Creates a `TUIDatePopover` View
  /// - Parameters:
  ///   - date: A bindable date value that acts as output when selected
  ///   - isShowing: A bindable bool value that used to show or hide this View
  ///   - isSelected: A bindable bool value that used to notify when date is selected
  public init(date: Binding<Date?>,
              isShowing: Binding<Bool>,
              isSelected: Binding<Bool>,
              showTime: Bool = true,
              minDate: Date? = nil,
              maxDate: Date? = nil) {
    
    self._date = date
    self._isShowing = isShowing
    self._isSelected = isSelected
    self.showTime = showTime
    self.minDate = minDate
    self.maxDate = maxDate
    self._storedDate = State<Date>.init(initialValue: date.wrappedValue ?? Date())
  }
  
  public var body: some View {
    
    ZStack {
      transparentBackground
      datePickerStack
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var transparentBackground: some View {
    VStack() {
      EmptyView()
    }
    .frame(maxWidth: .infinity,
           maxHeight: .infinity)
    .background(Color.black.opacity(0.1))
    .onTapGesture {
      isShowing = false
    }
  }
  
  @ViewBuilder
  private var datePickerStack: some View {
    VStack(spacing: Spacing.baseHorizontal) {
      
      HStack(spacing: Spacing.baseHorizontal) {
        
        Button("Cancel".localized) {
          isShowing = false
        }
        .frame(alignment: .trailing)
        .accessibilityIdentifier(Accessibility.done)
        
        Button("Clear".localized) {
          self.date = storedDate
          isSelected = true
          isShowing = false
        }
        .frame(alignment: .trailing)
        .accessibilityIdentifier(Accessibility.clear)
        
        Spacer()
        
        Button("Done".localized) {
          self.date = storedDate
          isSelected = true
          isShowing = false
        }
        .frame(alignment: .leading)
        .accessibilityIdentifier(Accessibility.cancel)
      }
      .padding(.horizontal, Spacing.custom(30))
      .padding(.top, Spacing.doubleVertical)
      
      datePicker
        .datePickerStyle(.graphical)
        .padding(.all, Spacing.custom(20))
        .accessibilityIdentifier(Accessibility.datePicker)
    }
    .frame(width: 350, alignment: .center)
    .background(Color.surface)
    .cornerRadius(5.0)
    .accessibilityIdentifier(Accessibility.transparentBackground)
  }
  
  @ViewBuilder
  private var datePicker: some View {
    var displayedComponents: DatePicker.Components {
      if showTime {
        return [.date, .hourAndMinute]
      }
      return [.date]
    }
    
    if let minDate, let maxDate {
      DatePicker(
        "",
        selection: $storedDate,
        in: minDate...maxDate,
        displayedComponents: displayComponents
      )
    } else if let minDate {
      DatePicker(
        "",
        selection: $storedDate,
        in: minDate...,
        displayedComponents: displayComponents
      )
    } else if let maxDate {
      DatePicker(
        "",
        selection: $storedDate,
        in: ...maxDate,
        displayedComponents: displayComponents
      )
    } else {
      DatePicker(
        "",
        selection: $storedDate,
        displayedComponents: displayComponents
      )
    }
  }
}

extension TUIDatePopover {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIDatePopover"
    case transparentBackground = "TransparentBackground"
    case datePicker = "DatePicker"
    case done = "Done"
    case clear = "Clear"
    case cancel = "Cancel"
  }
}

extension TUIDatePopover {
  
  public func displayComponents(_ displayComponents: DatePickerComponents) -> Self {
    var newView = self
    newView.displayComponents = displayComponents
    return newView
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
