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
    testView()
//    VStack {
//      Image(systemName: "globe")
//        .imageScale(.large)
//        .foregroundColor(.accentColor)
//      Text("Hello, world!")
//      Image(Symbol.map)
//    }
//    .padding()
  }
  
  @State var showWrapperIcon = true
  @ViewBuilder
  func testView() -> some View {
    
    TUITextRow("Title", style: .textDescription("Description to test with multiple number of lines to verify its adaptability"))
      .wrapperIcon {
        TUIWrapperIcon(image: Symbol.refresh) {
          showWrapperIcon = false
        }
        .iconColor(showWrapperIcon ? .black : .blue)
      }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
