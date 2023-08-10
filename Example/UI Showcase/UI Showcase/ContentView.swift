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
  
  @State var searchText = ""
  @State var isSearchEditing = false
  @State var isSyncDisabled = false
  
  var body: some View {
    
    VStack(spacing: 0) {
      Text("Hello, Detail View!")
      .background(.white)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .toolbar {
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button("Done") {
          isSearchEditing = false
        }
      }
    }
    .background(.gray)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onChange(of: searchText, perform: { value in
      print("Searching for \"\(searchText)\"")
    })
    .customNavigationBar(
      titleBarItem: titleBarItem,
      searchBarItem: searchBarItem)
  }
  
  private var searchBarItem: TUIAppTopBar.SearchBarItem {
    
    let searchItem = TUISearchItem(
      placeholder: "Search", text: $searchText, isEditing: $isSearchEditing)
    
    return .init(item: searchItem, backAction: { dismiss() })
  }
  
  private var titleBarItem: TUIAppTopBar.TitleBarItem {
    
    let searchButton = TUIIconButton(icon: .search24Regular) {
      isSearchEditing = true
    }
      .style(.ghost)
      .size(.size48)
    
    let syncButton = TUIIconButton(icon: .arrowCounterclockwise24Filled) {
      isSyncDisabled.toggle()
    }
      .style(.ghost)
      .size(.size48)
    
    return .init(
      title: "Detail View",
      leftButton: .back({
        dismiss()
      }),
      rightButtons: .two(
        .init(button: searchButton),
        .init(button: syncButton, isDisabled: $isSyncDisabled)))
  }
}

extension String {
  
  var localized: String {
    return NSLocalizedString(
      self, tableName: "Localizable",
      bundle: .main, value: self, comment: self)
  }
}
