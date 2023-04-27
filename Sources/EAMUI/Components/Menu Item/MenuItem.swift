//
//  MenuItem.swift
//  
//
//  Created by Arvindh Sukumar on 27/04/23.
//

import Foundation
import SwiftUI

public struct MenuItem {
  public var title: any StringProtocol
  public var configuration: Configuration
  
  public enum Configuration {
    case onlyLabel
    case withDescription(String)
    case withSymbol(EAMSymbol)
  }
  
  public init(title: any StringProtocol, configuration: MenuItem.Configuration) {
    self.title = title
    self.configuration = configuration
  }
}
