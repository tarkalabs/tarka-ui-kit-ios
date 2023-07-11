//
//  ContentView.swift
//  UI Showcase
//
//  Created by Arvindh Sukumar on 07/04/23.
//

import TarkaUI
import SwiftUI

struct ContentView: View {
  
  private var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
    return dateFormatter
  }()
  
  @StateObject var emptyDateFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "StartDate")
  
  @StateObject var dateFieldItem = TUIInputFieldItem(style: .titleWithValue, title: "StartDate", value: "2023-Feb-02 12:00:00")
  
  @StateObject var memoTextFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Enter Memo")
  
  @StateObject var valueOnlyTextFieldItem = TUIInputFieldItem(
    style: .onlyValue, value: "Input Text that received as text for memo")
  
  @StateObject var pickerFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Pick value")
  
  @State private var isTextFieldFocused: Bool = false
  
  public init() { }
  
  var body: some View {
    VStack {
      Button("Done") {
        print("""
Final input: Date - \(dateFieldItem.value)
First Text - \(memoTextFieldItem.value)
Second Text - \(valueOnlyTextFieldItem.value)
""")
      }
      TUIDateInputField()
        .endItem(withStyle: .icon(Symbol.document))
        .highlightBar(color: .red)
        .state(.success("Values are valid"))
        .environmentObject(emptyDateFieldItem)

      TUIPickerInputField()
      {
        ActivityView(activityItems: ["Test Export"], applicationActivities: nil)
      }
      .endItem(withStyle: .icon(Symbol.sync))
      .environmentObject(pickerFieldItem)
      
      TUITextInputField(
        isTextFieldFocused: $isTextFieldFocused)
      .state(.alert("Input values are sensitive"))
      .endItem(withStyle: .icon(Symbol.sync))
      .environmentObject(memoTextFieldItem)
      
      TUITextInputField(isTextFieldFocused: $isTextFieldFocused)
        .endItem(withStyle: .icon(Symbol.sync))
        .state(.error("Input values are sensitive"))
        .placeholder("Enter Memo Description")
        .environmentObject(valueOnlyTextFieldItem)
      
    }
    .scrollDismissesKeyboard(.immediately)
    .toolbar {
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button("Done") {
          isTextFieldFocused = false
        }
      }
    }
    //    VStack {
    //      Image(systemName: "globe")
    //        .imageScale(.large)
    //        .foregroundColor(.accentColor)
    //      Text("Hello, world!")
    //      Image(Symbol.map)
    //    }
    //    .padding()
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
