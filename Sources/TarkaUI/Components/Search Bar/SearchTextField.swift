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
    
    TextField("", text: $searchBarVM.searchItem.text,
              prompt: Text(searchBarVM.searchItem.placeholder).foregroundColor(.inputTextDim))
    .introspect(.textField, on: .iOS(.v16, .v17, .v18, .v26)) { textField in
      textField.addDoneButtonOnKeyboard {
        if (textField.text?.isEmpty ?? true) == false {
          performSearch()
        }
      }
    }
    .focused($isFocused)
    .onChange(of: isFocused) {
      searchBarVM.isEditing = $0
    }
    .onChange(of: searchBarVM.isEditing, perform: { value in
      if value != isFocused {
        isFocused = value
        searchBarVM.isFocused = value
      }
    })
    .accessibilityIdentifier(Accessibility.root)
    .submitLabel(searchBarVM.needDelaySearch ? .search : .return)
    .onSubmit(performSearch)
    .isEnabled(!searchBarVM.needDelaySearch) {
      $0.onChange(of: searchBarVM.searchItem.text, perform: updateSearchText)
    }
  }
  
  private func performSearch() {
    guard searchBarVM.needDelaySearch else { return }
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
