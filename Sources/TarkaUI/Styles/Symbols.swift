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
  case checkmarkCircle
  case info
  case warning
  case error
  
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
    case .checkmarkCircle:
      return .checkmarkCircle48Filled
    case .info:
      return .info48Filled
    case .warning:
      return .warning28Filled
    case .error:
      return .errorCircle24Filled
    }
  }
}
