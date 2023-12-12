//
//  LazyView.swift
//
//
//  Created by MAHESHWARAN on 12/12/23.
//

import SwiftUI

public struct LazyView<V: View>: View {
  public let build: () -> V
  
  public init(@ViewBuilder _ build: @escaping () -> V) {
    self.build = build
  }
  
  public var body: some View {
    build()
  }
}
