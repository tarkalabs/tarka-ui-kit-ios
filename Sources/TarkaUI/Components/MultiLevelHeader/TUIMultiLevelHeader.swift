//
//  TUIMultiLevelHeader.swift
//
//
//  Created by Arvindh Sukumar on 01/12/23.
//

import SwiftUI

public struct TUIMultiLevelHeader: View {
  @State private var isSelectable = false
  @State private var item: TUIMultiLevelHeaderItem
  
  public init(item: TUIMultiLevelHeaderItem) {
    self._item = .init(initialValue: item)
  }
  
  public var body: some View {
    VStack {
      contentView
    }
    .padding(.vertical, Spacing.baseVertical)
    .padding(.horizontal, Spacing.custom(12))
    .background(item.isSelectable ? Color.primaryAlt : Color.surface)
    .frame(maxWidth: .infinity)
  }
  
  @ViewBuilder
  private var contentView: some View {
    HStack(spacing: Spacing.custom(4)) {
      backButton
      pathTitle
    }
    .padding(Spacing.baseVertical)
  }
  
  @ViewBuilder
  private var backButton: some View {
    item.backButton
      .iconColor(item.isSelectable ? Color.onPrimaryAlt : Color.onSurface)
      .size(.size24)
  }
  
  @ViewBuilder
  private var pathTitle: some View {
    Text(item.pathTitle)
      .font(.heading6)
      .foregroundStyle(item.isSelectable ? Color.onPrimaryAlt : Color.onSurface)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct TUIMultiLevelHeader_Previews: PreviewProvider {
  static var previews: some View {
    TUIMultiLevelHeader(
      item: .init(
        path: ["path1", "path2"],
        isSelectable: true,
        backButton: TUIIconButton(
          icon: .chevronLeft24Regular,
          action: {
      
          }
        )
      )
    )
  }
}
