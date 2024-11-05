//
//  TUIAppBottomBar.swift
//
//
//  Created by Arvindh Sukumar on 05/06/24.
//

import SwiftUI

public struct TUIAppBottomBar: View {
  private var items: [Item]
  
  public init(items: [Item]) {
    self.items = items
  }
    
  public var body: some View {
    VStack(spacing: 0) {
      TUIDivider(orientation: .horizontal(hPadding: .zero, vPadding: .zero))
      
      mainView
    }
    .frame(maxWidth: .infinity)
  }
  
  @ViewBuilder
  private var mainView: some View {
    HStack {
      Spacer()
      
      ForEach(items) { item in
        TUIIconButton(icon: item.icon, action: item.action)
          .style(item.style)
          .isDisabled(!item.isEnabled)
        
        Spacer()
      }
    }
    .padding(.vertical, Spacing.baseVertical)
    .frame(maxWidth: .infinity)
    .background(Color.surface)
  }
}
