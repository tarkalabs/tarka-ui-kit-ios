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
  @State var text = ""
  @State var isEditing = false

  public init() { }
  
  var body: some View {

    let searchItem = TUISearchItem(placeholder: "Search", text: $text, isEditing: $isEditing)
    
    VStack(spacing: 20) {
      
      TUIAppTopBar(barStyle: .search(searchItem))
        .padding(.horizontal, 16)

      TUIAppTopBar(barStyle: .titleBar(.init(title: "Title", leftButton: .back, rightButtons: .none)))
        .padding(.horizontal, 16)
    }
    .scrollDismissesKeyboard(.immediately)
    .toolbar {
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button("Done") {
          isDoneClicked = true
          isEditing = false
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
