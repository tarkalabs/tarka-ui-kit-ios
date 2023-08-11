//
//  TUISearchBarItem.swift
//  
//
//  Created by Gopinath on 10/08/23.
//

import SwiftUI

public struct TUISearchBarItem {
  
  var placeholder: String
  @Binding var text: String
  @Binding public var isActive: Bool
  @Binding public var isEditing: Bool

  public init(placeholder: String,
              text: Binding<String>,
              isActive: Binding<Bool>,
              isEditing: Binding<Bool>) {
    
    self.placeholder = placeholder
    self._text = text
    self._isActive = isActive
    self._isEditing = isEditing
  }
}
