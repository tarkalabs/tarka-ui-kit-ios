//
//  TUISearchBar.swift
//  
//
//  Created by Gopinath on 21/07/23.
//

import SwiftUI

/// `TUISearchBar` is a SwiftUI view that used for search in a navigation bar.
/// The view can be customized with placeholder, back and right bar button items
///
public struct TUISearchBar: View {
  
  var backButton: TUIIconButton?
  var trailingButton: TUIIconButton?
  @ObservedObject var searchBarVM: TUISearchBarViewModel
  
  public init(searchBarVM: TUISearchBarViewModel) {
    self.searchBarVM = searchBarVM
  }
  
  public var body: some View {
    
    HStack(alignment: .center, spacing: Spacing.quarterHorizontal) {
      
      if let backButton {
        backButton
          .accessibilityIdentifier(Accessibility.backButton)
      }
      
      SearchBar(searchBarVM: searchBarVM)
      
      if let trailingButton {
        trailingButton
          .accessibilityIdentifier(Accessibility.trailingButton)
      }
    }
    .padding(Spacing.custom(4))
    .background(Color.inputBackground)
    .cornerRadius(75)
    .onChange(of: searchBarVM.searchItem.text, perform: { value in
      searchBarVM.onEditing(value)
    })
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUISearchBar {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUISearchBar"
    case backButton = "BackButton"
    case trailingButton = "TrailingButton"
  }
}
struct TUISearchBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @StateObject var searchBarVM = TUISearchBarViewModel(
      searchItem: .init(placeholder: "Search", text: "")) { _ in }

    TUISearchBar(searchBarVM: searchBarVM)
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

// Mark: - Modifiers

public extension TUISearchBar {
  
  func backButton(@ViewBuilder _ button: () -> TUIIconButton) -> Self {
    var newView = self
    newView.backButton = button()
    return newView
  }
  
  func trailingButton(@ViewBuilder _ button: () -> TUIIconButton?) -> Self {
    var newView = self
    let trailingButton = button()
    newView.trailingButton = trailingButton?.action {
      searchBarVM.searchItem.text = ""
    }
    return newView
  }
}

