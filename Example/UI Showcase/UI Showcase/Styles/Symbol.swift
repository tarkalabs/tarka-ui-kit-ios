//
//  Symbol.swift
//  UI Showcase
//
//  Created by Arvindh Sukumar on 16/05/23.
//

import Foundation
import TarkaUI
import FluentIcons

<<<<<<<< HEAD:Example/UI Showcase/UI Showcase/Styles/Symbol.swift
public enum Symbol: String, Icon {
========
public enum TUISymbol: String {
>>>>>>>> origin/main:Sources/TarkaUI/Styles/Symbols.swift
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
<<<<<<<< HEAD:Example/UI Showcase/UI Showcase/Styles/Symbol.swift
========


public extension Image {
  init(_ symbol: TUISymbol) {
    self.init(uiImage: UIImage(fluent: symbol.icon))
  }
}
>>>>>>>> origin/main:Sources/TarkaUI/Styles/Symbols.swift
