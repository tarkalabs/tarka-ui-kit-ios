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
      TUIBody(style: .hasValue(title: "Label", value: "Input Text"))
        .startItem(.init(item: .text("Title:")))
        .endItem(.init(item: .text("$")))
      
      TUIBody(style: .hasValue(title: "Label", value: "Input Text"))
        .startItem(.init(item: .icon(Symbol.sync)))
        .endItem(.init(item: .icon(Symbol.sync)))
      
      TUIBody(style: .hasValue(title: "Label", value: "Input Text"))
        .startItem(.init(item: .text("Title:")))
        .endItem(.init(item: .icon(Symbol.sync)))
      
      TUIBody(style: .hasValue(title: "Label", value: "Input Text"))
        .startItem(.init(item: .icon(Symbol.sync)))
        .endItem(.init(item: .text("$")))
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
