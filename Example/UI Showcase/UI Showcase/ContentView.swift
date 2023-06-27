//
//  ContentView.swift
//  UI Showcase
//
//  Created by Arvindh Sukumar on 07/04/23.
//

import TarkaUI
import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      TUIInputText(style: .titleWithValue(title: "Label", value: "Input Text"))
        .startItem(withStyle: .text("Title:"))
        .endItem(withStyle: .text("$"))
      
      TUIInputText(style: .titleWithValue(title: "Label", value: "Input Text"))
        .startItem(withStyle: .icon(Symbol.sync))
        .endItem(withStyle: .icon(Symbol.sync))
      
      TUIInputText(style: .titleWithValue(title: "Label", value: "Input Text"))
        .startItem(withStyle: .text("Title:"))
        .endItem(withStyle: .icon(Symbol.sync))
      
      TUIInputText(style: .titleWithValue(title: "Label", value: "Input Text"))
        .startItem(withStyle: .icon(Symbol.sync))
        .endItem(withStyle: .text("$"))
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
