//
//  TUIInputField+Modifiers.swift
//  
//
//  Created by Gopinath on 06/07/23.
//

import SwiftUI


/// This is the protocol that every InputField must conform
/// 
public protocol TUIInputFieldProtocol where Self: View {
  
  var properties: TUIInputFieldOptionalProperties { get set }
}

/// These extension functions act as a modifiers for Input fields that conform to this protocol
public extension TUIInputFieldProtocol {
  
  /// Adds the start item `TUIInputAdditionalView` view to the `TUIInputField` view in leading
  /// - Parameters:
  ///   - show: Bool value that decides whether to add or not
  ///   - style: Style that decides whether it is a text or icon
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI view that calls this func.
  ///
  func startItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.startItemStyle = show ? style : nil
    return newView
  }
  /// Adds the end item `TUIInputAdditionalView` view to the `TUIInputField` view in trailing
  /// - Parameters:
  ///   - show: Bool value that decides whether to add or not
  ///   - style: Style that decides whether it is a text or icon
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI view that calls this func.
  ///
  func endItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.endItemStyle = show ? style : nil
    return newView
  }

  /// Adds the highlight bar view to the `TUIInputField` view in the bottom in the vertical stack
  /// - Parameters:
  ///   - show: Bool value that decides whether to add or not
  ///   - color: Color for the highlight bar
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI view that calls this func.
  func highlightBar(_ show: Bool = true, color: Color) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.highlightBarColor = show ? color : nil
    return newView
  }

  /// Adds the `TUIHelperText` view to the `TUIInputField` view in the bottom in the vertical stack
  /// - Parameters:
  ///   - show: Bool value that decides whether to add or not
  ///   - _ helperText: A helper text view that to be displayed
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI view that calls this func.
  ///
  func helperText(show: Bool = true, @ViewBuilder _ helperText: () -> TUIHelperText) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.helperText = show ? helperText() : nil
    return newView
  }
  
  /// Adds the placeholder text to the text content filed of `TUIInputField` view
  /// - Parameters:
  ///   - value: String that to be shown as placeholder
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI view that calls this func.
  ///
  func placeholder(_ value: String) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.placeholder = value
    return newView
  }
  
  // Sets the `TUIInputFieldState` state for the `TUIInputField` view
  /// - Parameters:
  ///   - value: `TUIInputFieldState` state that has to be set for `TUIInputField` view
  /// - Returns: A `TUIInputFieldProtocol` conformed SwiftUI view that calls this func.
  /// 
  func state(_ value: TUIInputFieldState) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.state = value
    return newView
  }
}
