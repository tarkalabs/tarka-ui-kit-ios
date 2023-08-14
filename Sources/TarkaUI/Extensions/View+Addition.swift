//
//  View+ComponentLayer.swift
//  
//
//  Created by Gopinath on 11/08/23.
//

import SwiftUI

public extension View {
  
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
  
  /// Adds done button in toolbar
  /// - Parameter onClicked: closure that called when done button is clicked
  /// - Returns: View
  ///
  @ViewBuilder
  func addDoneButtonInToolbar(
    isDoneClicked: Binding<Bool>,
    onClicked: (() -> Void)? = nil) -> some View {
      modifier(ToolBarDoneButton(isDoneClicked: isDoneClicked))
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
  /// Adds `TUIMobileButtonBlock` in bottom of the screen
  /// - Parameter block: `TUIMobileButtonBlock`
  /// - Returns: View with button block added
  func addBottomMobileButtonBlock(_ block: TUIMobileButtonBlock) -> some View {
    
    GeometryReader { geometry in
      
      let safeAreaInset = geometry.safeAreaInsets.bottom
      ZStack(alignment: .bottom) {
        self
          .frame(maxHeight: .infinity)
        block
          .considerSafeArea(safeAreaInset > 0)
      }
      .edgesIgnoringSafeArea(.bottom)
    }
  }
}
