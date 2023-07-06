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
  case warning
  case error
  case person
  case info
  case success
  case checkBoxChecked
  case checkBoxUnChecked

  public var name: String {
    rawValue
  }
  
  public var fluentIcon: FluentIcon {
    switch self {
    case .chevronDown:
      return .chevronDown48Filled
    case .chevronRight:
      return .chevronRight48Filled
    case .chevronLeft:
      return .chevronLeft48Filled
    case .reorderDots:
      return .reOrderDotsVertical24Regular
    case .checkmarkCircle:
      return .checkmarkCircle48Filled
    case .info:
      return .info48Regular
    case .success:
      return .checkmarkCircle16Regular
    case .warning:
      return .warning28Filled
    case .person:
      return .person24Regular
    case .error:
      return .errorCircle24Filled
    case .checkBoxChecked:
      return .checkboxChecked24Filled
    case .checkBoxUnChecked:
      return .checkboxUnchecked24Filled
    }
  }
}
