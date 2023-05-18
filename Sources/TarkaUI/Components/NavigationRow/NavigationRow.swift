//
//  NavigationRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

/// A view that displays a navigation row with an optional symbol and badge count.
///
/// The navigation row is a horizontal stack with an optional symbol, title and badge count.
///
/// Example usage:
///
///     NavigationRow(
///       title: "Label",
///       symbol: .export,
///       badgeCount: 100
///     )
///
/// - Parameters:
///   - title: The title to display in the navigation row.
///   - symbol: The symbol to display in the navigation row. The default value is `nil`.
///   - badgeCount: The badge count to display in the navigation row. The default value is `nil`.
///
public struct NavigationRow: View {
  var title: any StringProtocol
  var symbol: Icon?
  var badgeCount: Int?
  
  /// Creates a navigation row with the specified title, symbol and badge count.
  ///
  /// - Parameters:
  ///   - title: The title to display in the navigation row.
  ///   - symbol: The symbol to display in the navigation row. The default value is `nil`.
  ///   - badgeCount: The badge count to display in the navigation row. The default value is `nil`.
  ///
  public init(title: any StringProtocol, symbol: Icon? = nil, badgeCount: Int? = nil) {
    self.title = title
    self.symbol = symbol
    self.badgeCount = badgeCount
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
      
      if let badgeCount = badgeCount {
        Badge(count: badgeCount) .badgeSize(.m)
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
    NavigationRow(title: "Label", symbol: Symbol.reorderDots, badgeCount: 100)
  }
}
