//
//  SafeAreaViewBlock.swift
//
//
//  Created by Gopinath on 16/08/23.
//

import SwiftUI

/// Adds view in bottom safe area with blur background
public struct BottomSafeAreaBlock<T>: ViewModifier where T: View {
  
  @State var viewHeight: CGFloat = 0
  
  var view: T
  var showView = false
  
  public init(view: T, showView: Bool = false) {
    self.view = view
    self.showView = showView
  }
  
  public func body(content: Content) -> some View {
    
    GeometryReader { geometry in
      
      let safeAreaBottomInset = geometry.safeAreaInsets.bottom
      
      content.frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
          
          VStack(spacing: 0) {
            if showView {
              ZStack {
                BackgroundBlur(radius: 7)
                view.getHeight($viewHeight)
              }
              .background(Color.surface50)
              .frame(height: viewHeight)
              Color.surface.frame(height: safeAreaBottomInset)
            }
          }
          .padding(.top, Spacing.halfVertical)
        }
        .isEnabled(showView) { view in
          view.edgesIgnoringSafeArea(.bottom)
        }
    }
  }
}
