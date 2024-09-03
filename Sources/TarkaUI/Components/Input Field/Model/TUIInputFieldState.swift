//
//  TUIInputFieldState.swift
//  
//
//  Created by Gopinath on 06/07/23.
//

import SwiftUI


/// This is the enum that defines the state of `TUIInputField` view.
/// According to this, the `TUIInputField` view displays the corresponding highlight bar and helper text
/// 
public enum TUIInputFieldState: Equatable {
  
  public static func == (lhs: TUIInputFieldState, rhs: TUIInputFieldState) -> Bool {
    switch lhs {
    case .none:
      if case .none = rhs {
        return true
      }
    case .focused:
      if case .focused = rhs {
        return true
      }
    case .inactive:
      if case .inactive = rhs {
        return true
      }
    case .error:
      if case .error = rhs {
        return true
      }
    case .alert:
      if case .alert = rhs {
        return true
      }
    case .success:
      if case .success = rhs {
        return true
      }
    case .disabled:
      if case .disabled = rhs {
        return true
      }
    }
    return false
  }
  
  case none
  case focused
  case inactive(String)
  case error(String)
  case alert(String)
  case success(String)
  case disabled(String)
  
  private var message: String? {
    switch self {
    case .none, .focused:
      return nil
    case .inactive(let message),
        .error(let message),
        .alert(let message),
        .success(let message),
        .disabled(let message):
      return message
    }
  }
  
  var highlightBarColor: Color? {
    switch self {
    case .focused: return .primaryTUI
    case .error: return .error
    default: return nil
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

