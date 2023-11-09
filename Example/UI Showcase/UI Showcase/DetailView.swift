//
//  DetailView.swift
//  UI Showcase
//
//  Created by Gopinath on 08/11/23.
//

import Foundation
import SwiftUI
import TarkaUI

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

struct DetailView: View {
  
  @State var isSyncDisabled = false

  @State var dateFieldItem = globalDateFieldItem
  
  @State var locationPickerFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Location")
  
  @State var pickerFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Pick value")
  
  @State var memoTextFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Enter Memo")
  
  @State var valueOnlyTextFieldItem = TUIInputFieldItem(
    style: .onlyValue, value: "Input Text that received as text for memo")
  
  
  @State private var isDoneClicked: Bool = false
  var body: some View {
    
    VStack(spacing: 0) {
      mainView
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .customNavigationBar(
      titleBarItem: titleBarItem,
      searchBarVM: searchBarVM)
  }
  
  @StateObject var searchBarVM = TUISearchBarViewModel(
    searchItem: .init(placeholder: "Search", text: "")) { value in
      print("Searching for \"\(value)\"")
    }
  
  private var titleBarItem: TUIAppTopBar.TitleBarItem {
    
    let searchButton = TUIIconButton(icon: .search24Regular) {
      searchBarVM.isShown = true
    }
      .style(.ghost)
      .size(.size48)
    
    let syncButton = TUIIconButton(icon: .arrowCounterclockwise24Filled) {
      isSyncDisabled.toggle()
    }
      .style(.ghost)
      .size(.size48)
      .isDisabled(isSyncDisabled)
    
    return .init(
      title: "Detail View",
      leftButton: .back(),
      rightButtons: .two(
        searchButton, syncButton))
  }
}

extension DetailView {
  
  @ViewBuilder
  var mainView: some View {

    let block = TUIMobileButtonBlock(
      style: .two(
        left: TUIButton(title: "Cancel") {
          isDoneClicked = true
        },
        right: TUIButton(title: "Save") {
          print("""
      Final input: Date - \(String(describing: dateFieldItem.date?.formatted(dateFieldItem.format)))
      First Text - \(memoTextFieldItem.value)
      Second Text - \(valueOnlyTextFieldItem.value)
      """)
          isDoneClicked = true
        }))

    ScrollView {
      VStack(spacing: 10) {
        inputFieldViews
        inputFieldViews
      }
    }
    .addDoneButtonInToolbar(onClicked: {
      isDoneClicked = true
      searchBarVM.isEditing = false
    })
    .addBottomMobileButtonBlock(
      block) {
      TUIChipView("Last seen \(Date().formatted())")
          .style(.input(.titleWithButton(.dismiss20Filled, action: {})))
        .padding(.bottom, 8)
    }
  }
  
  @ViewBuilder
  private var inputFieldViews: some View {
    VStack {
      
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
        inputItem: $memoTextFieldItem)
      .state(.alert("Input values are sensitive"))
      .endItem(withStyle: .icon(.arrowSyncCircle24Regular))
      .maxCharacters(7)
      .allowedCharacters(CharacterSet(charactersIn: "1234567890."))
      .setKeyboardType(.decimalPad)

      TUITextInputField(
        inputItem: $valueOnlyTextFieldItem)
      .endItem(withStyle: .icon(.arrowSyncCircle24Regular))
      .state(.error("Input values are sensitive"))
      .placeholder("Enter Memo Description")

      TUITextInputField(
        inputItem: $memoTextFieldItem)
      .state(.alert("Input values are sensitive"))
      .endItem(withStyle: .icon(.arrowSyncCircle24Regular))
      .maxCharacters(7)
      .allowedCharacters(CharacterSet(charactersIn: "1234567890."))
      .setKeyboardType(.decimalPad)

      TUITextInputField(
        inputItem: $valueOnlyTextFieldItem)
      .endItem(withStyle: .icon(.arrowSyncCircle24Regular))
      .state(.error("Input values are sensitive"))
      .placeholder("Enter Memo Description")
    }
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


