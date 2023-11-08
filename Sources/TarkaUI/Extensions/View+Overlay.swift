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
  
  ///  Overlay  sheet
  ///
  /// Example usage:
  ///
  ///       Text("Hello")
  ///         .onTapGesture { showSheet.toggle }
  ///         .overlaySheet(isPresented: $showSheet) {
  ///             SheetView()
  ///         }
  ///
  ///         struct SheetView: view {
  ///           @State private var height = CGFloat.zero
  ///
  ///           var body: some View {
  ///             Text("ShowSheet")
  ///             .getHeight($height)
  ///             .presentationDetents([.height(height)])
  ///           }
  ///         }
  ///
  /// - Parameters:
  ///   - isPresented: to show / dismiss
  ///   - content: This can be any swiftUI view that has to be presented
  /// - Returns: View
  ///
  @ViewBuilder
  func overlaySheet<V: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> V) -> some View {
    modifier(OverlaySheet(isPresented: isPresented, contentView: content))
  }
}
