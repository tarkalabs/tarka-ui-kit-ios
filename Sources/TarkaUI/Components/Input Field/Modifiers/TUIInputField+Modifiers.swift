//
//  TUIInputField+Modifiers.swift
//  
//
//  Created by Gopinath on 06/07/23.
//

import SwiftUI


/// This is the protocol that every input field components must conform
/// 
public protocol TUIInputFieldProtocol where Self: View {
  
  var properties: TUIInputFieldOptionalProperties { get set }
}

/// These extension functions act as a modifiers for Input field components that conform to this protocol
///
public extension TUIInputFieldProtocol {
  
  /// Adds the start item `TUIInputAdditionalView` View to the `TUIInputField` View in leading
  /// - Parameters:
  ///   - show: Bool value that decides whether to add or not
  ///   - style: Style that decides whether it is a text or icon
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI View that calls this func.
  ///
  func startItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.startItemStyle = show ? style : nil
    return newView
  }
  
  /// Adds the end item `TUIInputAdditionalView` View to the `TUIInputField` View in trailing
  /// - Parameters:
  ///   - show: Bool value that decides whether to add or not
  ///   - style: Style that decides whether it is a text or icon
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI View that calls this func.
  ///
  func endItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.endItemStyle = show ? style : nil
    return newView
  }
  
  /// Adds the highlight bar View to the `TUIInputField` View in the bottom in the vertical stack
  /// - Parameters:
  ///   - show: Bool value that decides whether to add or not
  ///   - color: Color for the highlight bar
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI View that calls this func.
  func highlightBar(_ show: Bool = true, color: Color) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.highlightBarColor = show ? color : nil
    return newView
  }
  
  /// Adds the `TUIHelperText` View to the `TUIInputField` View in the bottom in the vertical stack
  /// - Parameters:
  ///   - show: Bool value that decides whether to add or not
  ///   - _ helperText: A helper text view that to be displayed
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI View that calls this func.
  ///
  func helperText(show: Bool = true, @ViewBuilder _ helperText: () -> TUIHelperText) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.helperText = show ? helperText() : nil
    return newView
  }
  
  /// Adds the placeholder text to the text content field of `TUIInputField` View
  /// - Parameters:
  ///   - value: String that to be shown as placeholder
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI View that calls this func.
  ///
  func placeholder(_ value: String) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.placeholder = value
    return newView
  }
  
  /// Sets the `TUIInputFieldState` state for the `TUIInputField` View
  /// - Parameters:
  ///   - value: `TUIInputFieldState` state that has to be set for `TUIInputField` view
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI View that calls this func.
  /// 
  func state(_ value: TUIInputFieldState) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.state = value
    return newView
  }
  
  
  /// Sets the maximum chararcter limit for the textfield. It applies only for TUITextInputField.
  /// - Parameter limit: maximum character limit
  /// - Returns: TUITextInputField with character count limitation
  ///
  func textLimit(_ limit: Int) -> Self {
    guard var newView = self as? TUITextInputField else {
      return self
    }
    newView.textLimit = limit
    return newView as! Self
  }
  
  /// Restricts the user from entering disallowed characters. It applies only for `TUITextInputField`.
  /// - Parameter characters: Allowed Character set
  /// - Returns: TUITextInputField with character limitation
  ///
  func allowedCharacters(_ characters: String) -> some TUIInputFieldProtocol {
    guard var newView = self as? TUITextInputField else {
      return self
    }
    newView.allowedCharacters = characters
    return newView as! Self
  }
  
  /// Sets the Keyboard type for textField. It applies only for `TUITextInputField`.
  /// - Parameter keyboardType: UIKeyboardType
  /// - Returns: TUITextInputField with assigned keyboard
  ///
  func setKeyboardType(_ keyboardType: UIKeyboardType) -> some TUIInputFieldProtocol {
    guard var newView = self as? TUITextInputField else {
      return self
    }
    newView.keyboardType = keyboardType
    return newView as! Self
  }
}
