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
  
  /// This method is used to create navigationTextRow View with title and optional description,
  /// used in any swiftUI views
  ///
  @ViewBuilder
  func navigationTextRow(
    _ title: String,
    style: TUITextRow.Style,
    destinationView: some View,
    accessibilityID: TUIAccessibility,
    @TUIIconButtonBuilder iconButtons: @escaping () -> [TUIIconButton]) -> some View {
      
      NavigationLink(destination: destinationView, label: {
        TUITextRow(title, style: style)
          .wrapperIcon {
            TUIWrapperIcon(icon: .chevronRight20Filled)
              .iconColor(.outline)
          }
          .iconButtons(icons: iconButtons)
          .buttonStyle(.borderless)
          .accessibilityElement(children: .contain)
          .accessibilityIdentifier(accessibilityID)
      })
    }
  
  @ViewBuilder
  /// Adds `TUIMobileButtonBlock` in safe area bottom of the screen
  /// - Parameter block: `TUIMobileButtonBlock` that has to be added
  /// - Returns: View with button block added
  func addBottomMobileButtonBlock(_ block: TUIMobileButtonBlock) -> some View {
    
    GeometryReader { geometry in
      
      let safeAreaBottomInset = geometry.safeAreaInsets.bottom
      let block = block.addSafeAreaBottomInset(safeAreaBottomInset > 0 ? 20 : 0)
      
      self.frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 16) {
          block
        }
        .edgesIgnoringSafeArea(.bottom)
    }
  }
}
