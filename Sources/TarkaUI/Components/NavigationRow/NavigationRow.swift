//
//  NavigationRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

/// A view that displays a navigation row with an optional symbol and badge count.
///
/// The navigation row is a horizontal stack with an optional symbol, title and an optional extra view.
///
/// Example usage:
///
///     NavigationRow(
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
public struct NavigationRow<Content>: View where Content: View {
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
      if let symbol = symbol {
        imageView(symbol)

        Spacer()
          .frame(width: Spacing.baseHorizontal)
      }
      
      Text(title)
        .font(.heading7)
        .foregroundColor(.onSurface)
      
      Spacer()
      
      accessoryView()
      
      if showDetailDisclosure {
        DetailDisclosure()
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
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
      NavigationRow(title: "Label", symbol: Symbol.reorderDots) {
        TUIBadge(count: 100)
      }
      NavigationRow(title: "Label", symbol: Symbol.reorderDots) {
        TUIBadge(count: 100)
      }
      .detailDisclosure()
    }
  }
}
