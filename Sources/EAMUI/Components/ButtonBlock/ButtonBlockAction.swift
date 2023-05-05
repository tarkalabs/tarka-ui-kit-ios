//
//  ButtonBlockAction.swift
//  
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import Foundation

public protocol ButtonBlockAction {
  var id: String { get }
  var title: String { get }
  var leftIcon: EAMSymbol? { get }
  var rightIcon: EAMSymbol? { get }
  var handler: () -> Void { get }
}

@resultBuilder
public struct ButtonBlockActionBuilder {
  public static func buildBlock(_ components: any ButtonBlockAction...) -> [any ButtonBlockAction] {
    Array(components)
  }
}
