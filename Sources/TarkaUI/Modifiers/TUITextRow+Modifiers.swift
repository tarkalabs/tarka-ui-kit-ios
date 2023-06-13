//
//  TUITextRow+Modifiers.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

internal class IconButtonItem<Content: View>: ObservableObject {
  @Published var shouldShow: Bool
  @Published var icon: Content?
  
  init(shouldShow: Bool = false, icon: Content? = nil ) {
    self.shouldShow = shouldShow
    self.icon = icon
  }
}

public extension TUITextRow {
  
  func wrapperIcon(_ show: Bool = true,
                   @ViewBuilder content: @escaping () -> TUIWrapperIcon) -> TUITextRow {
    
    let iconButton = IconButtonItem(shouldShow: show, icon: content())
    
    var newView = self
    newView.wrapperIcon = iconButton
    return newView
  }
  
  func wrapperInfoIcon(_ show: Bool = true, action: @escaping () -> Void) -> some View {
    
    let iconButton = IconButtonItem(
      shouldShow: show,
      icon: TUIWrapperIcon.info(action: action))
    
    var newView = self
    newView.wrapperIcon = iconButton
    return newView
  }
  
  func iconButton(_ show: Bool = true,
                  @ViewBuilder icon: () -> TUIIconButton) -> some View {
    
    let iconButton = IconButtonItem(
      shouldShow: show,
      icon: icon())
    
    var newView = self
    newView.iconButton = iconButton
    return newView
  }
}
