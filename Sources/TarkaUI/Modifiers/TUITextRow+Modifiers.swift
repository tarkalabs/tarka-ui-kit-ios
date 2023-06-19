//
//  TUITextRow+Modifiers.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

public struct IconItem<Content>: Identifiable where Content: View {
  
  public var id = UUID().uuidString
  public var show = true
  public var icon: () -> Content
  
  public init(id: String = UUID().uuidString, show: Bool = true, icon: @escaping () -> Content) {
    self.id = id
    self.show = show
    self.icon = icon
  }
}

public extension TUITextRow {
  
  func wrapperIcon(_ show: Bool = true,
                   icon: @escaping () -> TUIWrapperIcon) -> TUITextRow {
    var newView = self
    let iconItem = IconItem(show: show, icon: icon)
    newView.wrapperIcon = iconItem
    return newView
  }
  
  func infoIcon(_ show: Bool = true,
                color: Color? = nil,
                action: @escaping () -> Void) -> TUITextRow {
    var newView = self
    let infoIcon: () -> TUIWrapperIcon = {
      TUIWrapperIcon.info(color: color, action: action)
    }
    newView.wrapperIcon =  IconItem(show: show, icon: infoIcon)
    return newView
  }
  
  func iconButtons(_ icons: @escaping () -> [IconItem<TUIIconButton>]) -> TUITextRow {
    var newView = self
    newView.iconButtons = icons()
    return newView
  }
}
