//
//  TUINavigationRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

/// A view that displays a navigation row with an optional symbol and badge count.
///
/// The navigation row is a horizontal stack with an optional symbol, title and an optional extra view.
///
/// `minHeight` of this View is 40. This is to match the exact design of our Design System
///
/// Example usage:
///
///     TUINavigationRow(
///       title: "Label",
///       symbol: .export,
///       accessoryView: {
///         TUIBadge()
///       }
///     )
///
/// - Parameters:
///   - title: The title to display in the navigation row.
///   - symbol: The symbol to display in the navigation row. The default value is `nil`.
///   - accessoryView: Extra content to display in the navigation row
///
public struct TUINavigationRow<Content>: View where Content: View {
  var title: any StringProtocol
  var symbol: Icon?
  var accessoryView: () -> Content
  
  @Environment(\.detailDisclosure) private var showDetailDisclosure
  
  /// Creates a navigation row with the specified title, symbol and an extra view.
  ///
  /// - Parameters:
  ///   - title: The title to display in the navigation row.
  ///   - symbol: The symbol to display in the navigation row. The default value is `nil`.
  ///   - accessoryView: Extra content to display in the navigation row.
  ///
  public init(
    title: any StringProtocol,
    symbol: Icon? = nil,
    @ViewBuilder _ accessoryView: @escaping () -> Content = { EmptyView() }
  ) {
    self.title = title
    self.symbol = symbol
    self.accessoryView = accessoryView
  }
  
  public var body: some View {
    
    HStack(alignment: .center, spacing: 0) {
      
      HStack(spacing: Spacing.baseHorizontal) {
        if let symbol = symbol {
          imageView(symbol)
        }
        Text(title)
          .font(.heading7)
          .foregroundColor(.onSurface)
          .padding(.vertical, Spacing.custom(3))
          .frame(minHeight: TarkaUI.Spacing.custom(18))
      }
      .padding(.vertical, Spacing.baseVertical)
      .padding(.horizontal, Spacing.halfHorizontal)
      
      Spacer(minLength: 0)
      
      HStack(spacing: Spacing.quarterHorizontal) {
        accessoryView()

        if showDetailDisclosure {
          TUIDetailDisclosure()
        }
      }
      .padding(.horizontal, Spacing.halfHorizontal)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    // set minHeight to match with design component
    .frame(minHeight: TarkaUI.Spacing.custom(40))
  }
  
  @ViewBuilder
  private func imageView(_ symbol: Icon) -> some View {
    Image(symbol)
      .resizable()
      .foregroundColor(.secondaryTUI)
      .frame(width: 24, height: 24)
  }
}

struct NavigationRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      VStack {
        TUINavigationRow(title: "Label") {
          TUIBadge(count: 4)
        }
        TUINavigationRow(title: "Label to test with multiple number of lines to verify its adaptability")
        TUINavigationRow(title: "Label", symbol: Symbol.reorderDots) {
          TUIBadge(count: 100)
        }
      }
      .detailDisclosure()
    }
  }
}
