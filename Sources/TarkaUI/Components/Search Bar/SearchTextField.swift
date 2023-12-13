//
//  SearchTextField.swift
//
//
//  Created by Gopinath on 10/08/23.
//

import SwiftUI


struct SearchTextField: View {
  
  @ObservedObject var searchBarVM: TUISearchBarViewModel
  @FocusState private var isFocused: Bool
  
  var body: some View {
    
    TextField(searchBarVM.searchItem.placeholder, text: $searchBarVM.searchItem.text)
      .focused($isFocused)
      .onTapGesture {
        searchBarVM.isEditing = true
      }
      .onChange(of: searchBarVM.isEditing, perform: { value in
        if value != isFocused {
          isFocused = value
        }
      })
      .accessibilityIdentifier(Accessibility.root)
      .submitLabel(searchBarVM.needDelaySearch ? .search : .return)
      .onSubmit(performSearch)
  }
  
  private func performSearch() {
    guard searchBarVM.needDelaySearch else { return }
    searchBarVM.onEditing(searchBarVM.searchItem.text)
  }
}

extension SearchTextField {
  enum Accessibility: String, TUIAccessibility {
    case root = "SearchTextField"
  }
}


struct SearchBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @StateObject var searchBarVM = TUISearchBarViewModel(
      searchItem: .init(placeholder: "Search", text: "")) { _ in }
    
    SearchTextField(searchBarVM: searchBarVM)
  }
}
