//
//  TUIAccessibility.swift
//  
//
//  Created by Arvindh Sukumar on 02/06/23.
//

import Foundation

public protocol TUIAccessibility {
  var identifier: String { get }
}

extension TUIAccessibility where Self: RawRepresentable, Self.RawValue == String {
  var identifier: String {
    rawValue
  }
}
