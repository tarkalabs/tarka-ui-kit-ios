//
//  ContentView.swift
//  UI Showcase
//
//  Created by Arvindh Sukumar on 07/04/23.
//

import TarkaUI
import SwiftUI

struct ContentView: View {
  
  @State private var isActive = false
  let coloredNavAppearance = UINavigationBarAppearance()

  init() {
    coloredNavAppearance.configureWithOpaqueBackground()
    coloredNavAppearance.backgroundColor = UIColor(theme.navColor)

    UINavigationBar.appearance().standardAppearance = coloredNavAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance

  }

  var body: some View {
    
    NavigationStack {
      NavigationLink {
        DetailView()
      } label: {
        Text("Hello, Nav View!")
      }
      
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct DetailView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @State var text = ""
  @State var isEditing = false
  @State var isSyncDisabled = false

  var body: some View {
    
    let searchItem = TUISearchItem(
      placeholder: "Search", text: $text, isEditing: $isEditing)
    
    let searchBarItem = TUIAppTopBar.SearchBarItem(
      item: searchItem,
      backAction: {
        dismiss()
      })
    
    var searchButton: TUIIconButton {
      TUIIconButton(icon: .search24Regular) {
        searchItem.isEditing = true
      }
      .style(.ghost)
      .size(.size48)
    }
    
    var syncButton: TUIIconButton {
      TUIIconButton(icon: .arrowCounterclockwise24Filled) {
        isSyncDisabled = true
      }
      .style(.ghost)
      .size(.size48)
    }
    
    let titleBarItem = TUIAppTopBar.BarItem(
      title: "Detail View",
      leftButton: .back({
        dismiss()
      }),
      rightButtons: .two(
        .init(button: searchButton),
        .init(button: syncButton, isDisabled: $isSyncDisabled)))
    
    VStack(spacing: 0) {
      Button("Hello, Detail View!") {
        searchItem.isEditing = true
      }
      .background(.white)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .toolbar {
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button("Done") {
          searchItem.isEditing = false
        }
      }
    }
    .background(.gray)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .customNavigationBar(
      titleBarItem: titleBarItem,
      searchBarItem: searchBarItem)
  }
}

extension String {
  
  var localized: String {
    return NSLocalizedString(
      self, tableName: "Localizable",
      bundle: .main, value: self, comment: self)
  }
}
