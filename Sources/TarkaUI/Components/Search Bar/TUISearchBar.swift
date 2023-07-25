//
//  TUISearchBar.swift
//  
//
//  Created by Gopinath on 21/07/23.
//

import SwiftUI

public struct TUISearchItem {
  
  var placeholder: String
  @Binding var text: String
  @Binding public var isEditing: Bool
  
  public init(placeholder: String,
              text: Binding<String>,
              isEditing: Binding<Bool>) {
    
    self.placeholder = placeholder
    self._text = text
    self._isEditing = isEditing
  }
}

public struct TUISearchBar: View {
  
  var backButton: TUIIconButton?
  var trailingButton: TUIIconButton?
  var searchItem: TUISearchItem
  
  public var body: some View {
    
    HStack(alignment: .center, spacing: 4) {
      
      if let backButton {
        backButton
      }
      
      SearchBar(searchItem: searchItem)
      
      if let trailingButton {
        trailingButton
      }
    }
    .padding(4)
    .background(Color.inputBackground)
    .cornerRadius(75)
  }
}

public extension TUISearchBar {
  
  func backButton(@ViewBuilder _ button: () -> TUIIconButton) -> Self {
    var newView = self
    newView.backButton = button()
    return newView
  }
  
  func trailingButton(@ViewBuilder _ button: () -> TUIIconButton?) -> Self {
    var newView = self
    newView.trailingButton = button()
    return newView
  }
}

struct TUISearchBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @State var text = ""
    @State var isEditing = false
    
    let searchItem = TUISearchItem(placeholder: "Search", text: $text, isEditing: $isEditing)
    
    TUISearchBar(searchItem: searchItem)
      .backButton {
        TUIIconButton(icon: .chevronLeft24Regular) { }
          .style(.ghost)
          .size(.size40)
      }
      .trailingButton {
        TUIIconButton(icon: .dismiss24Regular) { }
          .style(.ghost)
          .size(.size40)
      }
  }
}

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
    //        .animation(.default)
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
