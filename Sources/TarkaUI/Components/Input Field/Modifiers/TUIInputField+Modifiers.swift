//
//  TUIInputField+Modifiers.swift
//  
//
//  Created by Gopinath on 06/07/23.
//

import SwiftUI


/// This is the protocol that every InputField must confom
public protocol TUIInputFieldProtocol where Self: View {
  
  var properties: TUIInputFieldProperties { get set }
}

/// These extension functions act as a modifiers for Input fields that conform to this protocol
public extension TUIInputFieldProtocol {
  
  func startItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.startItemStyle = show ? style : nil
    return newView
  }
  
  func endItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.endItemStyle = show ? style : nil
    return newView
  }

  func highlightBar(_ show: Bool = true, color: Color) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.highlightBarColor = show ? color : nil
    return newView
  }
  
  func helperText(show: Bool = true, @ViewBuilder _ helperText: () -> TUIHelperText) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.helperText = show ? helperText() : nil
    return newView
  }
  
  func placeholder(_ value: String) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.placeholder = value
    return newView
  }
  
  func state(_ show: Bool = true, value: TUIInputFieldState) -> some TUIInputFieldProtocol {
    var newView = self
    newView.properties.state = show ? value : .none
    return newView
  }
}
