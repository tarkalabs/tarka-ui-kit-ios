//
//  BottomSafeAreaBlock.swift
//
//
//  Created by Gopinath on 16/08/23.
//

import SwiftUI

/// Adds view in bottom safe area with blur background
public struct BottomSafeAreaBlock<T>: ViewModifier where T: View {
  
  var view: T
  var showView = false
  var spacing: CGFloat
  var safeAreaColor: Color
  
  public init(
    view: T,
    showView: Bool,
    spacing: CGFloat, safeAreaColor: Color) {
      self.view = view
      self.showView = showView
      self.spacing = spacing
      self.safeAreaColor = safeAreaColor
    }
  
  public func body(content: Content) -> some View {
    
    if showView {
      GeometryReader { geometry in
        
        let safeAreaBottomInset = geometry.safeAreaInsets.bottom
        
        content
          .safeAreaInset(edge: .bottom, spacing: spacing) {
            
            VStack(spacing: 0) {
              view
              safeAreaColor.frame(height: safeAreaBottomInset)
            }
          }
          .edgesIgnoringSafeArea(.bottom)
      }
    } else {
      content
    }
  }
}
