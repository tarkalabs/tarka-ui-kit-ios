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
    case custom(left: TUIButton, right: TUIButton)
  }
  
  private var style: Style
  
  public init(style: Style) {
    self.style = style
  }
  
  private let fixedWidth: CGFloat = 342
  
  public var body: some View {
    
    ZStack {
      
      BackgroundBlur()
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.bottom)
      
      VStack(spacing: Spacing.custom(15)) {
        
        TUIDivider(
          orientation: .horizontal(
            hPadding: .zero, vPadding: .zero))
        .color(.surfaceVariant)
        
        buttonBlock
      }
      .background(Color.surface50)
    }
    .fixedSize(horizontal: false, vertical: true)
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var buttonBlock: some View {
    
    HStack(spacing: Spacing.halfHorizontal) {
      
      switch style {
        
      case .one(let button):
        button
          .style(.primary)
          .size(.xl)
          .width(.maximum(fixedWidth))
        
      case .two(let left, let right):
        left
          .style(.outlined)
          .size(.xl)
          .width(.maximum(.infinity))
          .accessibilityIdentifier(Accessibility.leftButton)
        right
          .style(.primary)
          .size(.xl)
          .width(.maximum(.infinity))
          .accessibilityIdentifier(Accessibility.rightButton)
        
      case .flexible(let left, let right):
        left
          .style(.outlined)
          .size(.xl)
          .accessibilityIdentifier(Accessibility.leftButton)
        right
          .style(.primary)
          .size(.xl)
          .width(.maximum(fixedWidth))
          .accessibilityIdentifier(Accessibility.rightButton)
      case .custom(let left, let right):
        left
          .size(.xl)
          .width(.maximum(fixedWidth))
          .accessibilityIdentifier(Accessibility.leftButton)
        right
          .size(.xl)
          .width(.maximum(fixedWidth))
          .accessibilityIdentifier(Accessibility.rightButton)

      }
    }
    .padding(.horizontal, Spacing.custom(24))
    .padding(.bottom, Spacing.custom(15))
    .frame(maxWidth: .infinity)
  }
}

extension TUIMobileButtonBlock {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIMobileButtonBlock"
    case leftButton = "LeftButton"
    case rightButton = "RightButton"
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

