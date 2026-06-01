//
//  SearchTextField.swift
//
//
//  Created by Gopinath on 10/08/23.
//

import SwiftUI
import SwiftUIIntrospect

struct SearchTextField: View {
  
  @ObservedObject var searchBarVM: TUISearchBarViewModel
  @FocusState private var isFocused: Bool
  
  var body: some View {
    
    TextField(
      "",
      text: $searchBarVM.searchItem.text,
      prompt:
        Text(searchBarVM.searchItem.placeholder)
        .foregroundColor(.inputTextDim)
    )
    .addDoneButtonOnKeyboard {
      // resign search
      searchBarVM.isEditing = false
      searchBarVM.isFocused = false
    }
    .focused($isFocused)
    .onChange(of: isFocused) {
      searchBarVM.isEditing = $0
      guard !isFocused else { return }
      // If search on done is enabled,
      // when focus is removed ie. keyboard hides, perform search
      guard searchBarVM.needDelaySearch else { return }
      performSearch()
    }
    .onChange(of: searchBarVM.isEditing, perform: { value in
      if value != isFocused {
        isFocused = value
        searchBarVM.isFocused = value
      }
    })
    .onAppear {
      guard searchBarVM.searchButtonClicked != nil else { return }
      isFocused = true
    }
    .onDisappear {
      searchBarVM.searchButtonClicked = nil
    }
    .accessibilityIdentifier(Accessibility.root)
    .submitLabel(searchBarVM.needDelaySearch ? .search : .return)
    .isEnabled(!searchBarVM.needDelaySearch) {
      $0.onChange(of: searchBarVM.searchItem.text, perform: updateSearchText)
    }
  }
  
  private func performSearch() {
    searchBarVM.onEditing(searchBarVM.searchItem.text)
    searchBarVM.searchText = searchBarVM.searchItem.text
  }
  
  private func updateSearchText(_ value: String) {
    searchBarVM.onEditing(value)
    searchBarVM.searchText = value
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
