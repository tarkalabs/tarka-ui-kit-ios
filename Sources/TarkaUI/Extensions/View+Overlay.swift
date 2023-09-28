//
//  View+Overlay.swift
//  
//
//  Created by Gopinath on 11/08/23.
//

import SwiftUI

public extension View {
  
  /// This method is used to create overlay View, in top trailing corner in any swiftUI views
  ///
  /// Example usage:
  ///
  ///      Text("Description")
  ///         .overlayView { Image(systemName: "star.fill") }
  ///
  @ViewBuilder
  func overlayView<Content: View>(_ content: () -> Content)  -> some View {
    self.overlay(alignment: .topTrailing) {
      content()
        .alignmentGuide(.top) { $0[.top] + 8 }
        .alignmentGuide(.trailing) { $0[.trailing] - 8 }
    }
  }
  
  @ViewBuilder
  func overlayViewInTopTrailing(_ show: Bool = true,
                                count: Int?, badgeSize: BadgeSize)  -> some View {
    if show {
      self.overlayView {
        TUIBadge(count: count)
          .badgeSize(badgeSize)
          .accessibilityIdentifier("TUIBadge")
      }
    } else {
      self
    }
  }
}
