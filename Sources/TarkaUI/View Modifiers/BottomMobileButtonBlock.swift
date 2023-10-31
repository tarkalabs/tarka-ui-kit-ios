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


public extension View {
  
  @ViewBuilder
  /// Adds `TUIMobileButtonBlock` in bottom safe area of the screen.
  /// This function itself makes the keyboard adaptive. No need to handle that explicitly.
  /// - Parameter block: `TUIMobileButtonBlock` that has to be added
  /// - Returns: View with button block added
  func addBottomMobileButtonBlock(
    _ block: TUIMobileButtonBlock,
    @ViewBuilder _ additionalView: () -> some View = { EmptyView() },
    showAdditionalView: Bool = false
  ) -> some View {
    
    let block = BottomMobileButtonBlock(
      block: block,
      additionalView: additionalView(),
      showAdditionalView: showAdditionalView)
    
    modifier(block)
  }
}
