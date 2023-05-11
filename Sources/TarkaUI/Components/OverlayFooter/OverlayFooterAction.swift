//
//  OverlayFooterAction.swift
//  
//
//  Created by Arvindh Sukumar on 05/05/23.
//

import Foundation

/// The `OverlayFooterAction` protocol defines the properties and methods required for an overlay footer action.
///
/// - Parameters:
///   - id: A unique identifier for the action. Needed for iterating over the actions in a `ForEach` loop.
///   - icon: The icon of the action.
///   - handler: The action to perform when the user taps the action.
///
public protocol OverlayFooterAction {
  var id: String { get }
  var icon: EAMSymbol { get }
  var handler: () -> Void { get }
}

/// The `OverlayFooterActionBuilder` result builder is used to build an array of `OverlayFooterAction` instances.
@resultBuilder
public struct OverlayFooterActionBuilder {
  public static func buildBlock(_ components: any OverlayFooterAction...) -> [any OverlayFooterAction] {
    Array(components)
  }
}
