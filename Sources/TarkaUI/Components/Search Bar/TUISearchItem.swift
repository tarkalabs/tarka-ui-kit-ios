//
//  TUISearchItem.swift
//  
//
//  Created by Gopinath on 10/08/23.
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
