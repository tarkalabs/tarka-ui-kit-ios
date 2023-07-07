//
//  TUIInputFieldProperties.swift
//  
//
//  Created by Gopinath on 06/07/23.
//

import SwiftUI

public struct TUIInputFieldOptionalProperties {
  
  var startItemStyle: TUIInputAdditionalView.Style?
  var endItemStyle: TUIInputAdditionalView.Style?
  var highlightBarColor: Color?
  var helperText: TUIHelperText?
  var placeholder: String?
  var state = TUIInputFieldState.none
}
