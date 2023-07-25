//
//  TUIThemeManager.swift
//  
//
//  Created by Arvindh Sukumar on 15/05/23.
//

import Foundation
import SwiftUI

public class TUIThemeManager {
  public static let shared = TUIThemeManager()
  public var theme: TUITheme = DefaultTheme()
  
  public func setTheme(_ theme: TUITheme) {
    self.theme = theme
  }
}

extension TUITheme {
  public var navColor: Color {
    return Color.gray
  }
}

public var theme = TUIThemeManager.shared.theme
