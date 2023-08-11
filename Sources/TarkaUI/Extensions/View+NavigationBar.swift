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
    searchBarItem: TUISearchBarItem? = nil) -> some View {
      
      GeometryReader { geometry in
        
        let barStyle = barStyle(
          titleBarItem: titleBarItem, searchBarItem: searchBarItem)
        
        let safeAreaInset = geometry.safeAreaInsets.top
        let minTop = max(safeAreaInset, 20)
        let top = min(minTop, 40)
        
        VStack(spacing: 0) {
          TUIAppTopBar(barStyle: barStyle)
            .padding(.top, top)
            .background(theme.navColor)
            .ignoresSafeArea()
          self
        }
        .edgesIgnoringSafeArea(.top)
        .toolbar(.hidden, for: .navigationBar)
      }
    }
  
  var safeAreaTop: CGFloat {
    
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({ $0.activationState == .foregroundActive })
      .map({ $0 as? UIWindowScene })
      .compactMap({ $0 })
      .first?.windows
      .filter({ $0.isKeyWindow }).first
    
    var top =  keyWindow?.safeAreaInsets.top ?? 0
    top = top == 0 ? 0 : 40
    return top
  }
  
  private func barStyle(titleBarItem: TUIAppTopBar.TitleBarItem,
                        searchBarItem: TUISearchBarItem? = nil) -> TUIAppTopBar.BarStyle {
    
    if let searchBarItem, searchBarItem.isActive {
      return .search(searchBarItem)
    } else {
      return .titleBar(titleBarItem)
    }
  }
}

struct DisabledView: ViewModifier {
  
  var isDisabled = false
  
  func body(content: Content) -> some View {
    content
      .disabled(isDisabled)
      .opacity(isDisabled ? 0.5 : 1)
  }
}

extension View {
  func isDisabled(_ isDisabled: Bool) -> some View {
    modifier(DisabledView(isDisabled: isDisabled))
  }
}
