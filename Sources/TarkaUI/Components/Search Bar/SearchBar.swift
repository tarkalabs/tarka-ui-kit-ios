//
//  SearchBar.swift
//  
//
//  Created by Gopinath on 10/08/23.
//

import SwiftUI


struct SearchBar: View {
  
  @ObservedObject var searchBarVM: TUISearchBarViewModel
  @FocusState private var isFocused: Bool
  @State private var text = "false"

  var body: some View {
    
    TextField(searchBarVM.searchItem.placeholder, text: $searchBarVM.searchItem.text)
      .focused($isFocused)
      .onTapGesture {
        searchBarVM.isEditing = true
      }
      .onChange(of: searchBarVM.isEditing, perform: { value in
        isFocused = value
      })
      .onAppear {
        searchBarVM.isEditing = true
      }
      .accessibilityIdentifier(Accessibility.root)
  }
}

extension SearchBar {
  enum Accessibility: String, TUIAccessibility {
    case root = "SearchBar"
  }
}


struct SearchBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @StateObject var searchBarVM = TUISearchBarViewModel(
      searchItem: .init(placeholder: "Search", text: ""))

    SearchBar(searchBarVM: searchBarVM)
  }
}