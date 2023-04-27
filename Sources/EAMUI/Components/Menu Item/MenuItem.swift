//
//  MenuItem.swift
//
//
//  Created by Arvindh Sukumar on 27/04/23.
//

import SwiftUI

public struct MenuItem: View {
  var label: any StringProtocol
  var style: Style

  public var body: some View {
    HStack(spacing: 0) {
      leftContentView
      contentView(forStyle: style)
      rightContentView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  @ViewBuilder
  private var leftContentView: some View {
    switch style {
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
  private func contentView(forStyle style: Style) -> some View {
    switch style {
    case .onlyLabel, .withSymbol:
      Text(label)
        .font(.body7)
        .foregroundColor(.onSurface)
    case .withDescription(let desc):
      VStack(alignment: .leading, spacing: Spacing.custom(2)) {
        Text(label)
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

public extension MenuItem {
  enum Style {
    case onlyLabel
    case withDescription(String)
    case withSymbol(EAMSymbol)
  }
}

struct MenuItem_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MenuItem(label: "Label", style: .withSymbol(.map))
          .previewDisplayName("With Symbol")
      
      MenuItem(label: "Label", style: .onlyLabel)
          .previewDisplayName("Only Label")
      
      MenuItem(label: "Label", style: .withDescription("Description"))
          .previewDisplayName("With Description")
    }
    .previewLayout(.sizeThatFits)
  }
}
