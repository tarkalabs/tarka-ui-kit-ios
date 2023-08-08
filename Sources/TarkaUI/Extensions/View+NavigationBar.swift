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
      self
        .navigationBarBackButtonHidden(true)
    }
  
  @ViewBuilder
  func customNavigationBar(
    titleBarItem: TUIAppTopBar.BarItem,
    searchBarItem: TUIAppTopBar.SearchBarItem? = nil) -> some View {
      
      GeometryReader { geometry in
        
        let barStyle = barStyle(
          titleBarItem: titleBarItem, searchBarItem: searchBarItem)
        
        let safeAreaInset = geometry.safeAreaInsets.top
        let minTop = max(safeAreaInset, 20)
        let top = min(minTop, 40)

        VStack(spacing: 1) {
          TUIAppTopBar(barStyle: barStyle)
            .padding(.top, top)
            .background(theme.navColor)
            .ignoresSafeArea()
          self
        }
        .edgesIgnoringSafeArea(.top)        //      .safeAreaInset(edge: .top, spacing: -10) {
        //        Text("")
        //          .frame(maxWidth: .infinity)
        //          .background(.indigo)
        //      }
        .navigationBarHidden(true)
      }
    }
  
  var safeAreaTop: CGFloat {
    
    let keyWindow = UIApplication.shared.connectedScenes
    
      .filter({$0.activationState == .foregroundActive})
    
      .map({$0 as? UIWindowScene})
    
      .compactMap({$0})
    
      .first?.windows
    
      .filter({$0.isKeyWindow}).first
    
    var top =  keyWindow?.safeAreaInsets.top ?? 0
    top = top == 0 ? 0 : 40
    return top
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
