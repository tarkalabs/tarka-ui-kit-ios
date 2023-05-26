//
//  TUIButtonBlockAction.swift
//  
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import Foundation

/// The `TUIButtonBlockAction` protocol defines the properties and methods required for a button block action.
/// 
/// - Parameters:
///   - id: A unique identifier for the action. Needed for iterating over the actions in a `ForEach` loop.
///   - title: The title of the action.
///   - leftIcon: The left icon of the action.
///   - rightIcon: The right icon of the action.
///   - handler: The action to perform when the user taps the button.
///
public protocol TUIButtonBlockAction {
  var id: String { get }
  var title: String { get }
  var leftIcon: Icon? { get }
  var rightIcon: Icon? { get }
  var handler: () -> Void { get }
}

/// The `ButtonBlockActionBuilder` result builder is used to build an array of `TUIButtonBlockAction` instances.
@resultBuilder
public struct ButtonBlockActionBuilder {
  public static func buildBlock(_ components: any TUIButtonBlockAction...) -> [any TUIButtonBlockAction] {
    Array(components)
  }
}
