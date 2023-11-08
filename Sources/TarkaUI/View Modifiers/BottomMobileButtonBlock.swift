//
//  BottomMobileButtonBlock.swift
//  
//
//  Created by Gopinath on 16/08/23.
//

import SwiftUI

struct BottomMobileButtonBlock<T>: ViewModifier where T: View {
  

  @State var isKeyboardShown: Bool = false
  @State var additionalViewHeight: CGFloat = 0

  var block: TUIMobileButtonBlock
  var additionalView: T
  var showAdditionalView = false

  func body(content: Content) -> some View {
    
    GeometryReader { geometry in
      
      let safeAreaBottomInset = geometry.safeAreaInsets.bottom
      let block = block
      
      content.frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
          if isKeyboardShown {
            EmptyView().frame(height: 0)
          } else {
            VStack(spacing: 0) {
              if showAdditionalView {
                ZStack {
                  BackgroundBlur(radius: 7)
                  additionalView.getHeight($additionalViewHeight)
                }
                .background(Color.surface50)
                .frame(height: additionalViewHeight)
              }
              block
              Color.surface.frame(height: safeAreaBottomInset)
            }
            .padding(.top, Spacing.halfVertical)
          }
        }
        .edgesIgnoringSafeArea(.bottom)
        .adaptiveKeyboard(isKeyboardShown: $isKeyboardShown)
    }
  }
}
