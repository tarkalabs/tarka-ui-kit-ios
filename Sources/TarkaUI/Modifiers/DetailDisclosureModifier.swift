//
//  DetailDisclosureModifier.swift
//  
//
//  Created by Arvindh Sukumar on 18/05/23.
//

import SwiftUI

extension EnvironmentValues {
  var detailDisclosure: Bool {
    get { self[DetailDisclosureEnvironmentKey.self] }
    set { self[DetailDisclosureEnvironmentKey.self] = newValue }
  }
}

struct DetailDisclosureEnvironmentKey: EnvironmentKey {
  static var defaultValue: Bool = false
}

public extension View {
  func detailDisclosure(_ show: Bool = true) -> some View {
    environment(\.detailDisclosure, show)
  }
}
