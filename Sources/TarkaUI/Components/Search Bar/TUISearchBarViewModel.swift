//
//  TUISearchBarViewModel.swift
//  
//
//  Created by Gopinath on 10/08/23.
//

import SwiftUI
import Combine

public struct TUISearchBarItem {
  
  public var placeholder: String
  public var text: String

  public init(placeholder: String,
              text: String = "") {
    
    self.placeholder = placeholder
    self.text = text
  }
}

public class TUISearchBarViewModel: ObservableObject {

  @Published public var searchItem: TUISearchBarItem
  @Published public var isShown: Bool = false
  @Published public var isEditing = false
  
  @Published public var searchText = ""
  
  public var needDelaySearch: Bool
  var onEditing: (String) -> Void

  public init(
    searchItem: TUISearchBarItem,
    isShown: Bool = false,
    needDelaySearch: Bool = false,
    onEditing: @escaping (String) -> Void) {
      self.needDelaySearch = needDelaySearch
      self._searchItem = Published(initialValue: searchItem)
      self._isShown = Published(initialValue: isShown)
      self.onEditing = onEditing
    }
  
  public init(
    searchItem: TUISearchBarItem,
    isShown: Bool = false,
    needDelaySearch: Bool = false) {
      self.needDelaySearch = needDelaySearch
      self.searchItem = searchItem
      self.isShown = isShown
      onEditing = { _ in }
    }
}
