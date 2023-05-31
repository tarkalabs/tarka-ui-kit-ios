//
//  ThemeManager.swift
//  
//
//  Created by Arvindh Sukumar on 15/05/23.
//

import Foundation

public class ThemeManager {
  public static let shared = ThemeManager()
  public var theme: Theme = DefaultTheme()
  
  public func setTheme(_ theme: Theme) {
    self.theme = theme
  }
}
