//
//  ContentView.swift
//  UI Showcase
//
//  Created by Arvindh Sukumar on 07/04/23.
//

import TarkaUI
import SwiftUI

private var testDate: Date {
  let dateFormatter = DateFormatter()
  dateFormatter.timeZone = TimeZone(abbreviation: "GMT+5:30")!
  dateFormatter.dateFormat = "dd MMM yyyy hh:mm:ss a"
  
  let dateGiven = "4 Jul 2023 9:11:00 AM" // EAM
  let dateValue = dateFormatter.date(from: dateGiven) ?? Date()
  return dateValue
}

var emptyFormat: Date.FormatStyle {
  .init(date: .abbreviated, time: .standard)
}

var dateFormat: Date.FormatStyle {
  .init(date: .numeric, time: .standard)
}

var globalEmptyDateFieldItem = TUIDateInputFieldItem(
  style: .onlyTitle, title: "StartDate",
  format: emptyFormat)

var globalDateFieldItem = TUIDateInputFieldItem(
  style: .onlyTitle, title: "StartDate",
  date: testDate,
  format: dateFormat)

struct ContentView: View {
  
  @State var dateFieldItem = globalDateFieldItem
  
  @State var locationPickerFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Location")
  
  @State var pickerFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Pick value")
  
  @State var memoTextFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Enter Memo")
  
  @State var valueOnlyTextFieldItem = TUIInputFieldItem(
    style: .onlyValue, value: "Input Text that received as text for memo")
  
  
  @State private var isDoneClicked: Bool = false
  
  public init() { }
  
  var body: some View {
    
    ZStack(alignment: .bottom) {
      
      inputFiledViews
      
      TUIMobileButtonBlock(
        style: .flexible(
          left: TUIButton(title: "Label") { },
          right: TUIButton(title: "Label") { }
        ))
    }
  }
  
  @ViewBuilder
  private var inputFiledViews: some View {
    VStack {
      Button("Submit") {
        
        print("""
Final input: Date - \(String(describing: dateFieldItem.date?.formatted(dateFieldItem.format)))
First Text - \(memoTextFieldItem.value)
Second Text - \(valueOnlyTextFieldItem.value)
""")
      }
      TUIDateInputField(dateInputItem: $dateFieldItem)
        .endItem(withStyle: .icon(.document24Regular))
        .highlightBar(color: .red)
        .state(.success("Values are valid"))
      
      TUIInteractiveInputField(inputItem: $locationPickerFieldItem) {
        self.locationPickerFieldItem.style = .titleWithValue
        self.locationPickerFieldItem.value = "20.123242, 73.24426t2"
      }
      .endItem(withStyle: .icon(.document24Regular))
      .highlightBar(color: .red)
      .state(.success("Values are valid"))
      
      TUIPickerInputField(inputItem: $pickerFieldItem)
      {
        ActivityView(activityItems: ["Test Export"], applicationActivities: nil)
      }
      .endItem(withStyle: .icon(.arrowSyncCircle24Regular))
      
      TUITextInputField(
        inputItem: $memoTextFieldItem, isDoneClicked: $isDoneClicked)
      .state(.alert("Input values are sensitive"))
      .endItem(withStyle: .icon(.arrowSyncCircle24Regular))
      
      TUITextInputField(
        inputItem: $valueOnlyTextFieldItem, isDoneClicked: $isDoneClicked)
      .endItem(withStyle: .icon(.arrowSyncCircle24Regular))
      .state(.error("Input values are sensitive"))
      .placeholder("Enter Memo Description")
    }
    .scrollDismissesKeyboard(.immediately)
    .toolbar {
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button("Done") {
          isDoneClicked = true
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct ActivityView: UIViewControllerRepresentable {
  typealias UIViewControllerType = UIActivityViewController
  
  var activityItems: [Any]
  var applicationActivities: [UIActivity]? = nil
  
  func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

extension String {
  
  var localized: String {
    return NSLocalizedString(
      self, tableName: "Localizable",
      bundle: .main, value: self, comment: self)
  }
}
