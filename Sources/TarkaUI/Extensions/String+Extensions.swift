//
//  File.swift
//
//
//  Created by Arvindh Sukumar on 18/05/23.
//

import Foundation

public extension String {
  var initials: String {
    let words = self.components(separatedBy: " ")
    let initials = words.compactMap { $0.first }
    return String(initials).uppercased()
  }
}
