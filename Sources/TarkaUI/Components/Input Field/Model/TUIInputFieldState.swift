//
//  TUIInputFieldState.swift
//  
//
//  Created by Gopinath on 06/07/23.
//

import SwiftUI

public enum TUIInputFieldState {
  
  case none
  case inactive(String)
  case focused(String)
  case error(String)
  case alert(String)
  case success(String)
  case disabled(String)
  
  private var message: String? {
    switch self {
    case .none:
      return nil
    case .inactive(let message):
      return message
    case .focused(let message):
      return message
    case .error(let message):
      return message
    case .alert(let message):
      return message
    case .success(let message):
      return message
    case .disabled(let message):
      return message
    }
  }
  
  var highlightBarColor: Color? {
    switch self {
    case .focused:
      return .primaryTUI
    case .error:
      return .error
    case .alert:
      return .warning
    case .success:
      return .success
    default:
      return nil
    }
  }
  
  func helperText() -> TUIHelperText? {
    guard let message else { return nil }
    switch self {
    case .error:
      return TUIHelperText(style: .error, message: message)
    case .alert:
      return TUIHelperText(style: .warning, message: message)
    case .success:
      return TUIHelperText(style: .success, message: message)
    default:
      return TUIHelperText(style: .hint, message: message)
    }
  }
}

