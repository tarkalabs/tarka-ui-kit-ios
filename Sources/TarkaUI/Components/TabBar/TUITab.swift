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
    HStack {
      labelView
    }
    .background(GeometryReader { proxy in
      Color.clear
        .preference(key: TabWidthPreferenceKey.self, value: [proxy.size.width])
    })
  }
  
  @ViewBuilder
  private var labelView: some View {
    Text(tab.title)
      .font(.button6)
      .padding(.horizontal, Spacing.baseHorizontal)
      .padding(.vertical, Spacing.custom(6))
      .frame(minHeight: 20)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      
  }
}

#Preview {
  TUITab(tab: .init("Tab")) { _ in
    
  }
}
