//
//  ButtonBlockAction.swift
//  
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import Foundation

/// The `ButtonBlockAction` protocol defines the properties and methods required for a button block action.
/// 
/// - Parameters:
///   - id: A unique identifier for the action. Needed for iterating over the actions in a `ForEach` loop.
///   - title: The title of the action.
///   - leftIcon: The left icon of the action.
///   - rightIcon: The right icon of the action.
///   - handler: The action to perform when the user taps the button.
///
public protocol ButtonBlockAction {
  var id: String { get }
  var title: String { get }
  var leftIcon: EAMSymbol? { get }
  var rightIcon: EAMSymbol? { get }
  var handler: () -> Void { get }
}

/// The `ButtonBlockActionBuilder` result builder is used to build an array of `ButtonBlockAction` instances.
@resultBuilder
public struct ButtonBlockActionBuilder {
  public static func buildBlock(_ components: any ButtonBlockAction...) -> [any ButtonBlockAction] {
    Array(components)
  }
}
