//
//  SearchBar.swift
//  
//
//  Created by Gopinath on 10/08/23.
//

import SwiftUI


struct SearchBar: View {
  
  var searchItem: TUISearchItem
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
      .transition(.move(edge: .trailing))
  }
}

struct SearchBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @State var text = ""
    @State var isEditing = false
    
    let searchItem = TUISearchItem(
      placeholder: "Search", text: $text, isEditing: $isEditing)
    
    SearchBar(searchItem: searchItem)
  }
}
