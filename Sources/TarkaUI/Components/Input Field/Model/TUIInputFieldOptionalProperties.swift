//
//  TUIInputFieldProperties.swift
//  
//
//  Created by Gopinath on 06/07/23.
//

import SwiftUI

/// This is the struct that holds the optional values to create multiple variants of `TUIInputField` view
/// 
public struct TUIInputFieldOptionalProperties {
  
  var startItemStyle: TUIInputAdditionalView.Style?
  var endItemStyle: TUIInputAdditionalView.Style?
  var highlightBarColor: Color?
  var helperText: TUIHelperText?
  var placeholder: String?
  var state = TUIInputFieldState.none
}