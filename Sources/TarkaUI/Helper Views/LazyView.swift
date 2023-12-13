//
//  LazyView.swift
//
//
//  Created by MAHESHWARAN on 12/12/23.
//

import SwiftUI

/// LazyView is a SwiftUI
///
/// The `LazyView` is a container view that displays a contents only when a view is visible,
/// This lazyView will solve the issue where nested views are getting initialized too early.
///
/// Example usage:
///
///     LazyView {
///       HStack {
///         Text("Description")
///           .font(.heading6)
///           .foregroundColor(Color.inputText)
///       }
///     }
///
/// - Parameters:
///   - build: A closure that returns the content
///
/// - Returns: A view that represents a content.
public struct LazyView<V: View>: View {
  public let build: () -> V
  
  public init(@ViewBuilder _ build: @escaping () -> V) {
    self.build = build
  }
  
  public var body: some View {
    build()
  }
}
