//
//  View+NavigationBar.swift
//  
//
//  Created by Gopinath on 24/07/23.
//

import SwiftUI

public extension View {
  
  @ViewBuilder
  func customNavigationBar(
    titleBarItem: TUIAppTopBar.TitleBarItem,
    searchBarVM: TUISearchBarViewModel? = nil) -> some View {
      
      GeometryReader { geometry in
        
        let barStyle = barStyle(
          titleBarItem: titleBarItem, searchBarVM: searchBarVM)
        
        let safeAreaInset = geometry.safeAreaInsets.top
        let minTop = max(safeAreaInset, 20)
        let top = min(minTop, 40)
        
        VStack(spacing: 0) {
          TUIAppTopBar(barStyle: barStyle)
            .padding(.top, top)
            .ignoresSafeArea()
          self
        }
        .edgesIgnoringSafeArea(.top)
        .toolbar(.hidden, for: .navigationBar)
      }
    }
  
  private func barStyle(titleBarItem: TUIAppTopBar.TitleBarItem,
                        searchBarVM: TUISearchBarViewModel? = nil) -> TUIAppTopBar.BarStyle {
    
    if let searchBarVM, searchBarVM.isActive {
      return .search(searchBarVM)
    } else {
      return .titleBar(titleBarItem)
    }
  }
}

