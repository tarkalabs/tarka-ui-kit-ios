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
              text: String) {
    
    self.placeholder = placeholder
    self.text = text
  }
}

public class TUISearchBarViewModel: ObservableObject {

  @Published public var searchItem: TUISearchBarItem
  @Published public var isActive: Bool = false
  @Published public var isEditing = false

  public init(searchItem: TUISearchBarItem) {
    self._searchItem = Published(initialValue: searchItem)
  }
}
