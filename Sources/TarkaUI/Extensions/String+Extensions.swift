//
//  File.swift
//
//
//  Created by Arvindh Sukumar on 18/05/23.
//

import Foundation

extension String {
  
  var localized: String {
    return NSLocalizedString(
      self, tableName: "Localizable",
      bundle: .main, value: self, comment: self)
  }
  
  var initials: String {
    let words = self.components(separatedBy: " ")
    let initials = words.compactMap { $0.first }
    return String(initials).uppercased()
  }
}
