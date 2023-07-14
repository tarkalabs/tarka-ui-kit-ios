//
//  File.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public struct TUIMobileButtonBlock: View {
  
  public enum Style {
    case one(TUIButton)
    case two(left: TUIButton, right: TUIButton)
    case flexible(left: TUIButton, right: TUIButton)
  }
  
  var style: Style
  public init(style: Style) {
    self.style = style
  }
  
  public var body: some View {
    
    HStack(spacing: Spacing.halfHorizontal) {
      
      switch style {
        
      case .one(let button):
        button
          .style(.primary)
          .size(.large)
          .width(.infinity)
        
      case .two(let left, let right):
        left
          .style(.outlined)
          .size(.large)
          .width(.infinity)
        right
          .style(.primary)
          .size(.large)
          .width(.infinity)
        
      case .flexible(let left, let right):
        left
          .style(.outlined)
          .size(.large)
        right
          .style(.primary)
          .size(.large)
          .width(.infinity)
      }
    }
    .padding(.horizontal, Spacing.custom(24))
    .padding(.top, 15)
    .padding(.bottom, 16)
    .frame(maxWidth: .infinity)
    .background(Color.surface50)
  }
}

struct TUIMobileButtonBlock_Previews: PreviewProvider {
  
  static var previews: some View {
    
    VStack {
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
      .padding(.all, 16)
    }
    .background(Color.background)
  }
}
