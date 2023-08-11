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
  var searchItem: TUISearchBarItem
  
  public init(searchItem: TUISearchBarItem) {
    self.searchItem = searchItem
  }
  
  public var body: some View {
    
    HStack(alignment: .center, spacing: Spacing.quarterHorizontal) {
      
      if let backButton {
        backButton
      }
      
      SearchBar(searchItem: searchItem)
      
      if let trailingButton {
        trailingButton
      }
    }
    .padding(Spacing.custom(4))
    .background(Color.inputBackground)
    .cornerRadius(75)
  }
}

struct TUISearchBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @State var text = ""
    @State var isActive = false
    @State var isEditing = false
    
    let searchItem = TUISearchBarItem(
      placeholder: "Search", text: $text,
      isActive: $isActive, isEditing: $isEditing)
    
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
      searchItem.text = ""
    }
    return newView
  }
}

