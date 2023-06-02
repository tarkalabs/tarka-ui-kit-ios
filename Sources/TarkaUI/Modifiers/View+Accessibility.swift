//
//  View+Accessibility.swift
//  
//
//  Created by Arvindh Sukumar on 02/06/23.
//

import SwiftUI

extension View {
  func accessibilityIdentifier(_ accessibility: TUIAccessibility) -> some View {
    self
      .accessibilityIdentifier(accessibility.identifier)
  }
}

