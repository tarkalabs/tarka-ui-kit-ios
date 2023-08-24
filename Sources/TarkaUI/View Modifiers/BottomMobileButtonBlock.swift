//
//  BottomMobileButtonBlock.swift
//  
//
//  Created by Gopinath on 16/08/23.
//

import SwiftUI

struct BottomMobileButtonBlock<T>: ViewModifier where T: View {
  
  @State var isKeyboardShown: Bool = false
  @Binding var bottomHeight: CGFloat
  
  var block: TUIMobileButtonBlock
  var additionalView: T? = nil
  
  func body(content: Content) -> some View {
    
    GeometryReader { geometry in
      
      let safeAreaBottomInset = geometry.safeAreaInsets.bottom
      // Set manual value of `20` for bottom safe area inset, as default inset seems more spacious
      let block = block.addSafeAreaBottomInset(safeAreaBottomInset > 0 ? Spacing.custom(20) : 0)
      
      content.frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: Spacing.doubleVertical) {
          if isKeyboardShown {
            EmptyView().frame(height: 0)
          } else {
            VStack(spacing: 0) {
              additionalView
              block
            }
            .getHeight($bottomHeight)
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
    bottomHeight: Binding<CGFloat> = .constant(0),
    @ViewBuilder _ additionalView: () -> some View = { EmptyView() }) -> some View {
      
      let block = BottomMobileButtonBlock(
        bottomHeight: bottomHeight,
        block: block,
        additionalView: additionalView())
      
      modifier(block)
  }
}
