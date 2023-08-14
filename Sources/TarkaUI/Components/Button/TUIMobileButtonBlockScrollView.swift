//
//  TUIMobileButtonBlockScrollView.swift
//  
//
//  Created by Gopinath on 11/08/23.
//

import SwiftUI


public struct TUIMobileButtonBlockScrollView<Content>: View where Content: View {
  
  var content: () -> Content
  var buttonBlock: TUIMobileButtonBlock
  
  public init(
    buttonBlock: TUIMobileButtonBlock,
    @ViewBuilder content: @escaping () -> Content) {
      self.content = content
      self.buttonBlock = buttonBlock
    }

  public var body: some View {
    
    GeometryReader { geometry in
      
      let safeAreaInset = geometry.safeAreaInsets.bottom
      let block = buttonBlock.considerSafeArea(safeAreaInset > 0)

        ScrollView {
          content() 
          Color.clear.frame(height: block.minHeight)
        }
        .addBottomMobileButtonBlock(block)
    }
  }
}
