//
//  File.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

/// `TUIMobileButtonBlock` is a SwiftUI view that shows TUIButtons in a horizontal stack.
/// The view can be customized with different styles, to configure the position of buttons,
/// and its width
///
public struct TUIMobileButtonBlock: View {
  
  public enum Style {
    case one(TUIButton)
    case two(left: TUIButton, right: TUIButton)
    case flexible(left: TUIButton, right: TUIButton)
  }
  
  private var style: Style
  
  public init(style: Style) {
    self.style = style
  }
  
  let fixedWidth: CGFloat = 342
  
  public var body: some View {
    
    VStack(spacing: Spacing.custom(15)) {
      
      TUIDivider()
        .horizontal(lrPadding: .zero, tbPadding: .zero)

      buttonBlock
    }
    .background(Color.surface50)
  }
  
  @ViewBuilder
  private var buttonBlock: some View {
    HStack(spacing: Spacing.halfHorizontal) {
      
      switch style {
        
      case .one(let button):
        button
          .style(.primary)
          .size(.large)
          .width(.fixed(fixedWidth))
        
      case .two(let left, let right):
        left
          .style(.outlined)
          .size(.large)
          .width(.maximum(.infinity))
        right
          .style(.primary)
          .size(.large)
          .width(.maximum(.infinity))
        
      case .flexible(let left, let right):
        left
          .style(.outlined)
          .size(.large)
        right
          .style(.primary)
          .size(.large)
          .width(.maximum(fixedWidth))
      }
    }
    .padding(.horizontal, Spacing.custom(24))
    .padding(.bottom, Spacing.doubleVertical)
    .frame(maxWidth: .infinity)
    .frame(minHeight: 88)
  }
}

struct TUIMobileButtonBlock_Previews: PreviewProvider {
  
  static var previews: some View {
    
    VStack(spacing: 0) {
      VStack(spacing: 16) {
        TUIMobileButtonBlock(
          style: .one(
            TUIButton(title: "Label") { }
          ))
        
        TUIMobileButtonBlock(
          style: .two(
            left:
              TUIButton(title: "Label") { },
            right: TUIButton(title: "Label") { }
          ))

        TUIMobileButtonBlock(
          style: .flexible(
            left: TUIButton(title: "Label") { },
            right: TUIButton(title: "Label") { }
          ))
      }
    }
    .background(Color.background)
  }
}
