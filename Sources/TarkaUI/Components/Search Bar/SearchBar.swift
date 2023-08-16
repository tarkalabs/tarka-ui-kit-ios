//
//  SearchBar.swift
//  
//
//  Created by Gopinath on 10/08/23.
//

import SwiftUI


struct SearchBar: View {
  
  var searchItem: TUISearchBarItem
  @FocusState private var isFocused: Bool
  
  var body: some View {
    
    TextField(searchItem.placeholder, text: searchItem.$text)
      .focused($isFocused)
      .onTapGesture {
        searchItem.isEditing = true
      }
      .onChange(of: searchItem.$isEditing.wrappedValue, perform: { value in
        isFocused = value
      })
      .onAppear {
        searchItem.isEditing = true
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
    
    @State var text = ""
    @State var isActive = false
    @State var isEditing = false
    
    let searchItem = TUISearchBarItem(
      placeholder: "Search", text: $text,
      isActive: $isActive, isEditing: $isEditing)
    
    SearchBar(searchItem: searchItem)
  }
}
