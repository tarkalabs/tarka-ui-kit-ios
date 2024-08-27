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
public enum TUIInputFieldState: Equatable, Hashable {
  
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
  case inactive(String, showIcon: Bool = true)
  case error(String, showIcon: Bool = true)
  case alert(String, showIcon: Bool = true)
  case success(String, showIcon: Bool = true)
  case disabled(String, showIcon: Bool = true)
  
  private var message: String? {
    switch self {
    case .none, .focused:
      return nil
    case .inactive(let message, _),
        .error(let message, _),
        .alert(let message, _),
        .success(let message, _),
        .disabled(let message, _):
      return message
    }
  }
  
  private var showIcon: Bool {
    switch self {
    case .none, .focused:
      return false
    case .inactive(_, let showIcon),
        .error(_, let showIcon),
        .alert(_, let showIcon),
        .success(_, let showIcon),
        .disabled(_, let showIcon):
      return showIcon
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
      return TUIHelperText(style: .error, message: message, showIcon: showIcon)
    case .alert:
      return TUIHelperText(style: .warning, message: message, showIcon: showIcon)
    case .success:
      return TUIHelperText(style: .success, message: message, showIcon: showIcon)
    default:
      return TUIHelperText(style: .hint, message: message, showIcon: showIcon)
    }
  }
}

