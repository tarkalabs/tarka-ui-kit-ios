//
//  View+Modifiers.swift
//  
//
//  Created by MAHESHWARAN on 03/08/23.
//

import SwiftUI

public extension View {
  
  /// List Row Insets used to create a new view based on the padding amount
  /// - Parameters:
  ///   - vertical: vertical padding amount
  ///   - horizontal: horizontal padding amount
  /// - Returns: A view that's padded by the amount you specify.
  ///
  func listRowInsets(_ vertical: CGFloat, _ horizontal: CGFloat) -> some View {
    self.listRowInsets(EdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal))
  }
  
  /// This method is used to vaildate the condition, if it's then it will create new view else return the same view
  ///
  /// Example usage:
  ///
  ///     HStack {
  ///         Text("Description")
  ///         .isEnabled(isSelected) { $0.foregroundColor(.green) }
  ///       }
  ///     }
  ///
  /// - Parameters:
  ///   - show: This bool is used to vaildate the condition
  ///   - content: The content can be any SwiftUI view.
  /// - Returns: A closure that returns the content
  @ViewBuilder
  func isEnabled<Content: View>(_ show: Bool, content: (Self) -> Content) -> some View {
    if show {
      content(self)
    } else {
      self
    }
  }
  
  
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
  func overlayViewInTopTrailing(_ show: Bool = true, count: Int?, badgeSize: BadgeSize)  -> some View {
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
  
  /// This method is used to create border View in any swiftUI views
  ///
  /// Example usage:
  ///
  ///      Text("Description")
  ///         .borderView(RoundedRectangle(cornerRadius: Spacing.halfHorizontal), width: 1, color: .gray)
  ///
  @ViewBuilder
  func borderView(_ shape: some Shape, width: CGFloat = 0, color: Color = .clear) -> some View {
    self
      .clipShape(shape)
      .overlay(shape.stroke(color, lineWidth: width))
  }
  
  /// This method is used to create content Unavailable View in any swiftUI views
  ///
  /// Example usage:
  ///
  ///      Color.gray.opacity(0.4)
  ///         .contentUnavailableView(.init("No Work type", icon: .errorCircle24Regular), show: false)
  ///
  @ViewBuilder
  func contentUnavailableView(_ content: TUIContentUnavailableView, show: Bool = true) -> some View {
    if show {
      content
    } else {
      self
    }
  }
  
  /// This method is used to create navigationTextRow View with title and optional description, used in any swiftUI views
  ///
  @ViewBuilder
  func navigationTextRow(
    _ title: String,
    style: TUITextRow.Style,
    destinationView: some View,
    accessibilityID: TUIAccessibility,
    isEnabled: Bool = true,
    @TUIIconButtonBuilder iconButtons: @escaping () -> [TUIIconButton]) -> some View {
      let textRow = TUITextRow(title, style: style)
      
      if isEnabled {
        NavigationLink(destination: destinationView, label: {
          textRow
            .wrapperIcon {
              TUIWrapperIcon(icon: .chevronRight20Filled)
                .iconColor(.outline)
            }
            .iconButtons(icons: iconButtons)
            .buttonStyle(.borderless)
        })
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(accessibilityID)
      } else {
        textRow
          .buttonStyle(.borderless)
          .accessibilityElement(children: .contain)
          .accessibilityIdentifier(accessibilityID)
      }
    }
}
