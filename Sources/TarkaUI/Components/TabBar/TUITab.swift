//
//  TUITab.swift
//
//
//  Created by Arvindh Sukumar on 12/02/24.
//

import SwiftUI

struct TUITab: View {
  var tab: TUITabItem
  var isSelected: Bool = false
  var onTap: (TUITabItem) -> ()
  
  var body: some View {
    Button {
      onTap(tab)
    } label: {
      contentView
    }
  }
  
  @ViewBuilder
  private var contentView: some View {
    HStack(spacing: 0) {
      if let icon = tab.icon {
        iconView(icon)
      }
      
      labelView
    }
    .background(GeometryReader { proxy in
      Color.clear
        .preference(key: TabWidthPreferenceKey.self, value: [proxy.size.width])
    })
  }
  
  @ViewBuilder
  private func iconView(_ icon: FluentIcon) -> some View {
    Image(fluent: icon)
      .padding(.leading, Spacing.custom(6))
      .frame(width: 20, height: 20)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
  }
  
  @ViewBuilder
  private var labelView: some View {
    let title = tab.count > 0 ? "\(tab.title) (\(tab.count))" : tab.title
    Text(title)
      .font(.button6)
      .padding(.leading, tab.icon == nil ? Spacing.baseHorizontal : Spacing.custom(4))
      .padding(.trailing, Spacing.baseHorizontal)
      .padding(.vertical, Spacing.custom(6))
      .frame(minHeight: 20)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .fixedSize(horizontal: true, vertical: false)
  }
}

#Preview {
  TUITab(tab: .init("Tab", icon: .circle20Regular)) { _ in
    
  }
}
