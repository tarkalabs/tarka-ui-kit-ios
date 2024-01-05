//
//  TUIIconButtonBuilder.swift
//  
//
//  Created by Gopinath on 22/06/23.
//

import Foundation

/// The `TUIIconButtonBuilder` result builder is used to build an array of `TUIIconButton` instances.
@resultBuilder
public struct TUIIconButtonBuilder {
 
  // Single button
  public static func buildBlock(_ components: TUIIconButton...) -> [TUIIconButton] {
    return components
  }
  
  /// Add support for both single and collections of buttons.
  public static func buildExpression(_ expression: TUIIconButton) -> [TUIIconButton] {
    [expression]
  }
  
  /// Add support for both single and collections of buttons.
  public static func buildExpression(_ expression: TUIIconButton?) -> [TUIIconButton] {
    []
  }
  
  public static func buildBlock(_ components: [TUIIconButton]...) -> [TUIIconButton] {
    components.flatMap { $0 }
  }
  
  /// Add support for optionals.
  public static func buildOptional(_ components: [TUIIconButton]?) -> [TUIIconButton] {
    components ?? []
  }
  
  /// Add support for if statements.
  public static func buildEither(first component: TUIIconButton) -> [TUIIconButton] {
    return [component]
  }
  
  public static func buildEither(second component: TUIIconButton) -> [TUIIconButton] {
    return [component]
  }
  
  /// Add support for loops.
  public static func buildArray(_ components: [[TUIIconButton]]) -> [TUIIconButton] {
    components.flatMap { $0 }
  }
}
