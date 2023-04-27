//
//  MenuItemView.swift
//
//
//  Created by Arvindh Sukumar on 27/04/23.
//

import SwiftUI

public struct MenuItemView: View {
  public var item: MenuItem

  public init(item: MenuItem) {
    self.item = item
  }

  public var body: some View {
    HStack(spacing: 0) {
      leftContentView
      contentView
      rightContentView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  @ViewBuilder
  private var leftContentView: some View {
    switch item.configuration {
    case .withSymbol(let symbol):
      Image(symbol)
        .resizable()
        .scaledToFill()
        .frame(width: 24, height: 24)
        .padding(.leading, Spacing.baseHorizontal)
        .padding(.trailing, Spacing.halfHorizontal)
    default:
      Spacer()
        .frame(width: 48)
    }
  }
  
  @ViewBuilder
  private var contentView: some View {
    switch item.configuration {
    case .onlyLabel, .withSymbol:
      Text(item.title)
        .font(.body7)
        .foregroundColor(.onSurface)
    case .withDescription(let desc):
      VStack(alignment: .leading, spacing: Spacing.custom(2)) {
        Text(item.title)
          .font(.heading6)
          .foregroundColor(.onSurface)
        Text(desc)
          .font(.body6)
          .foregroundColor(.onSurface)
      }
    }
  }
  
  @ViewBuilder
  private var rightContentView: some View {
    // TODO: Implement this
    EmptyView()
  }
}

struct MenuItemView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MenuItemView(
        item: MenuItem(
          title: "Label",
          configuration: .withSymbol(.map)
        )
      )
    
      MenuItemView(
        item: MenuItem(
          title: "Label",
          configuration: .onlyLabel
        )
      )
      
      MenuItemView(
        item: MenuItem(
          title: "Label",
          configuration: .withDescription("Description")
        )
      )
    }
    .previewLayout(.sizeThatFits)
  }
}
