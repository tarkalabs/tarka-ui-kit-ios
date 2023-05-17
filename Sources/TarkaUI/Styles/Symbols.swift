//
//  Symbols.swift
//  
//
//  Created by Arvindh Sukumar on 18/04/23.
//

import SwiftUI
import FluentIcons

public enum TUISymbol: String {
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
  case map
  case questionCircle
  case refresh
  case reorderDots
  case search
  case shield
  case sync
  case tabs
  
  var icon: FluentIcon {
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


public extension Image {
  init(_ symbol: TUISymbol) {
    self.init(uiImage: UIImage(fluent: symbol.icon))
  }
}
