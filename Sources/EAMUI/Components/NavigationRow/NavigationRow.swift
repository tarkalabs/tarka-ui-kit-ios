//
//  NavigationRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

public struct NavigationRow: View {
  var title: any StringProtocol
  var symbol: EAMSymbol?
  var badgeCount: Int?
  
  public init(title: any StringProtocol, symbol: EAMSymbol? = nil, badgeCount: Int? = nil) {
    self.title = title
    self.symbol = symbol
    self.badgeCount = badgeCount
  }
  
  public var body: some View {
    HStack(alignment: .center, spacing: 0) {
      if let symbol = symbol {
        imageView(symbol)
          .padding(.horizontal, Spacing.halfHorizontal)

        Spacer()
          .frame(width: Spacing.halfHorizontal)
      }
      
      Text(title)
        .font(.heading7)
        .foregroundColor(.onSurface)
      
      Spacer()
      
      if let badgeCount = badgeCount {
        Badge(count: badgeCount, size: .m)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  @ViewBuilder
  private func imageView(_ symbol: EAMSymbol) -> some View {
    Image(symbol)
      .resizable()
      .foregroundColor(.secondaryEAM)
      .frame(width: 24, height: 24)
  }
}

struct NavigationRow_Previews: PreviewProvider {
  static var previews: some View {
    NavigationRow(title: "Label", symbol: .export, badgeCount: 100)
  }
}
