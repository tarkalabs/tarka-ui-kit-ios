//
//  Spacing.swift
//  
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import Foundation

public enum Spacing {
  public static let none: CGFloat = 0
  
  public static let baseVertical: CGFloat = 8
  public static let doubleVertical: CGFloat = baseVertical * 2
  public static let halfVertical: CGFloat = baseVertical / 2
  public static let quarterVertical: CGFloat = baseVertical / 4

  public static let baseHorizontal: CGFloat = 16
  public static let halfHorizontal: CGFloat = baseHorizontal / 2
  public static let quarterHorizontal: CGFloat = baseHorizontal / 4

  public static func custom(_ spacing: CGFloat) -> CGFloat {
    spacing
  }
  
  public static func verticalMultiple(_ multiplier: CGFloat) -> CGFloat {
    baseVertical * multiplier
  }
  
  public static func horizontalMultiple(_ multiplier: CGFloat) -> CGFloat {
    baseHorizontal * multiplier
  }
}
