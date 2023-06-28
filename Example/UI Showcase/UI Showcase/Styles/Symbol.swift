//
//  Symbol.swift
//  UI Showcase
//
//  Created by Arvindh Sukumar on 16/05/23.
//

import Foundation
import TarkaUI
import FluentIcons

public enum Symbol: String, Icon {
  case chevronDown
  case chevronRight
  case chevronLeft
  case checkmarkStarburst
  case copy
  case delete
  case dismiss
  case document
  case documentDownload
  case documentError
  case export
  case info
  case map
  case questionCircle
  case refresh
  case reorderDots
  case search
  case shield
  case sync
  case tabs
  
  public var name: String {
    rawValue
  }
  
  public var fluentIcon: FluentIcon {
    switch self {
    case .chevronDown:
      return .chevronDown48Regular
    case .chevronRight:
      return .chevronRight48Regular
    case .chevronLeft:
      return .chevronLeft48Regular
    case .checkmarkStarburst:
      return .checkmarkStarburst24Regular
    case .copy:
      return .copy32Regular
    case .delete:
      return .delete48Regular
    case .dismiss:
      return .dismiss48Regular
    case .document:
      return .document48Regular
    case .documentDownload:
      return .documentHeaderArrowDown24Regular
    case .documentError:
      return .documentError24Regular
    case .export:
      return .arrowExport24Regular
    case .info:
      return .info48Regular
    case .map:
      return .map24Regular
    case .questionCircle:
      return .questionCircle48Regular
    case .refresh:
      return .arrowCounterclockwise48Regular
    case .reorderDots:
      return .reOrderDotsVertical24Regular
    case .search:
      return .search48Regular
    case .shield:
      return .shield48Regular
    case .sync:
      return .arrowSyncCircle24Regular
    case .tabs:
      return .tabs24Regular
    }
  }
}
