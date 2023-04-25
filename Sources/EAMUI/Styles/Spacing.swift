//
//  Spacing.swift
//  
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import Foundation

public enum Spacing {
  public static let base: CGFloat = 4
  public static let double: CGFloat = Spacing.base * 2
  public static let half: CGFloat = Spacing.base / 2
  
  public static func custom(_ spacing: CGFloat) -> CGFloat {
    spacing
  }
  
  public static func multiple(_ multiplier: CGFloat) -> CGFloat {
    Spacing.base * multiplier
  }
}
