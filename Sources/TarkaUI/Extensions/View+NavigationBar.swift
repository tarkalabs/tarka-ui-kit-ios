//
//  View+NavigationBar.swift
//  
//
//  Created by Gopinath on 24/07/23.
//

import SwiftUI

public extension View {
  
  @ViewBuilder
  func navigationBar(
    titleBarItem: TUIAppTopBar.BarItem,
    searchBarItem: TUIAppTopBar.SearchBarItem? = nil) -> some View {
      
      let barStyle = barStyle(
        titleBarItem: titleBarItem, searchBarItem: searchBarItem)
      
      VStack(spacing: 0) { }
        .padding(.bottom, barStyle.extraPadding) // default extra padding
        .toolbar {
          
          ToolbarItem(placement: .principal) {
            
            TUIAppTopBar(barStyle: barStyle)
              .padding(.horizontal, -8) // default extra padding
              .ignoresSafeArea()
          }
        }
    }
  
  private func barStyle(titleBarItem: TUIAppTopBar.BarItem,
                        searchBarItem: TUIAppTopBar.SearchBarItem? = nil) -> TUIAppTopBar.BarStyle {
    
    if let searchBarItem, searchBarItem.item.isEditing {
      return .search(searchBarItem)
    } else {
      return .titleBar(titleBarItem)
    }
  }
}
