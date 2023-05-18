//
//  Symbols.swift
//  
//
//  Created by Arvindh Sukumar on 18/04/23.
//

import SwiftUI
import FluentIcons

public protocol Icon {
  var name: String { get }
  var fluentIcon: FluentIcon { get }
}

public extension Image {
  init(_ icon: Icon) {
    self.init(uiImage: UIImage(fluent: icon.fluentIcon))
  }
}

internal enum Symbol: String, Icon {
  case chevronDown
  case chevronRight
  case chevronLeft
  case reorderDots
  
  public var name: String {
    rawValue
  }
  
  public var fluentIcon: FluentIcon {
    switch self {
    case .chevronDown:
      return .chevronDown48Filled
    case .chevronRight:
      return .iosChevronRight20Filled
    case .chevronLeft:
      return .chevronLeft48Filled
    case .reorderDots:
      return .reOrderDotsVertical24Regular
    }
  }
}
