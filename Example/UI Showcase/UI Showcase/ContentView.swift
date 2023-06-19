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
  @State var showBinIcon = true
  @State var showDocIcon = true
  @State var showInfoIcon = true

  @ViewBuilder
  func testView() -> some View {
    
    VStack {
      TUITextRow("Title", style: .textDescription("Description"))
      
        .wrapperIcon(showWrapperIcon, icon: {

            TUIWrapperIcon(
              image: Symbol.chevronRight, action: {
                showWrapperIcon = false
              })
            .iconColor(.red)
          })
      
      TUITextRow("Title", style: .onlyTitle)
        .iconButtons({
          [
            IconItem(show: showBinIcon) {
              TUIIconButton(icon: Symbol.delete, action: { showBinIcon = false })
            },
            
            IconItem(show: showDocIcon) {
              TUIIconButton(icon: Symbol.document, action: { showDocIcon = false })
            }
          ]
        })
        .infoIcon(showInfoIcon, color: .blue) { showInfoIcon = false }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
