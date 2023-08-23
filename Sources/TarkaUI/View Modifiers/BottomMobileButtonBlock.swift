//
//  BottomMobileButtonBlock.swift
//  
//
//  Created by Gopinath on 16/08/23.
//

import SwiftUI

struct BottomMobileButtonBlock: ViewModifier {
  
  @State var isKeyboardShown: Bool = false
  var block: TUIMobileButtonBlock
  
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
            block
          }
        }
        .edgesIgnoringSafeArea(.bottom)
        .adaptiveKeyboard(isKeyboardShown: $isKeyboardShown)
    }
  }
}

public extension View {
  /// Adds `TUIMobileButtonBlock` in bottom safe area of the screen.
  /// This function itself makes the keyboard adaptive. No need to handle that explicitly.
  /// - Parameter block: `TUIMobileButtonBlock` that has to be added
  /// - Returns: View with button block added
  func addBottomMobileButtonBlock(_ block: TUIMobileButtonBlock) -> some View {
      
      modifier(BottomMobileButtonBlock(block: block))
  }
}

