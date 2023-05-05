//
//  OverlayFooterAction.swift
//  
//
//  Created by Arvindh Sukumar on 05/05/23.
//

import Foundation

public protocol OverlayFooterAction {
  var id: String { get }
  var icon: EAMSymbol { get }
  var handler: () -> Void { get }
}

@resultBuilder
public struct OverlayFooterActionBuilder {
  public static func buildBlock(_ components: any OverlayFooterAction...) -> [any OverlayFooterAction] {
    Array(components)
  }
}
