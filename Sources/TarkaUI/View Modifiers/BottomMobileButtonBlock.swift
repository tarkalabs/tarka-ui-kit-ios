//
//  BottomMobileButtonBlock.swift
//  
//
//  Created by Gopinath on 16/08/23.
//

import SwiftUI

struct BottomMobileButtonBlock<T>: ViewModifier where T: View {
  
  @State var isKeyboardShown: Bool = false
  
  var block: TUIMobileButtonBlock
  var additionalView: T? = nil
  
  func body(content: Content) -> some View {
    
    GeometryReader { geometry in
      
      let safeAreaBottomInset = geometry.safeAreaInsets.bottom
      let minimumExpectedSafeAreaInset = 24.0
      let block = block.hasSafeArea(safeAreaBottomInset > minimumExpectedSafeAreaInset)
      
      content.frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: Spacing.doubleVertical) {
          if isKeyboardShown {
            EmptyView().frame(height: 0)
          } else {
            VStack(spacing: 0) {
              additionalView
              block
            }
          }
        }
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
    @ViewBuilder _ additionalView: () -> some View = { EmptyView() }) -> some View {
      
      let block = BottomMobileButtonBlock(
        block: block,
        additionalView: additionalView())
      
      modifier(block)
  }
}
