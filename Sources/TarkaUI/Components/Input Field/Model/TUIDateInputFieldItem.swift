//
//  TUIDateInputFieldItem.swift
//  
//
//  Created by Gopinath on 11/07/23.
//

import SwiftUI

public struct TUIDateInputFieldItem: Hashable {
    
  public var style: TUIInputFieldStyle
  public var title: String = ""
  public var date: Date?
  public var format: Date.FormatStyle
  
  public init(style: TUIInputFieldStyle, title: String, date: Date? = nil, format: Date.FormatStyle) {
    self.style = style
    self.title = title
    self.date = date
    self.format = format
  }
}
