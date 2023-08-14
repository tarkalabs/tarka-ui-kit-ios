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
  private var considerSafeArea: Bool = false

  public init(style: Style) {
    self.style = style
  }
  
  private let fixedWidth: CGFloat = 342
  private let blurRadius: CGFloat = 7

  public var body: some View {
    
    ZStack(alignment: .bottom) {
      
      BackgroundBlur(radius: blurRadius)
        .frame(maxWidth: .infinity)
      
      VStack(spacing: Spacing.custom(15)) {
        
        TUIDivider(
          orientation: .horizontal(
            hPadding: .zero, vPadding: .zero))
        
        buttonBlock
      }
      .background(Color.surface50)
    }
    .frame(minHeight: minHeight)
    .fixedSize(horizontal: false, vertical: true)
  }
  
  @ViewBuilder
  private var buttonBlock: some View {
    HStack(spacing: Spacing.halfHorizontal) {
      
      switch style {
        
      case .one(let button):
        button
          .style(.primary)
          .size(.large)
          .width(.maximum(fixedWidth))
        
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
    .padding(.bottom, buttonBottomPadding)
    .isEnabled(considerSafeArea, content: { view in
      VStack(spacing: 10) {
        view
        BackgroundBlur(radius: blurRadius)
          .frame(maxWidth: .infinity)
      }
    })
    .frame(maxWidth: .infinity)
  }
  
  public var minHeight: CGFloat {
    guard considerSafeArea else { return 80 }
    return 96
  }
  
  private var buttonBottomPadding: CGFloat {
    guard considerSafeArea else {
      return Spacing.doubleVertical
    }
    return 0
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

public extension TUIMobileButtonBlock {
  
  /// Considers safe area and reduces bottom height as safe area itself provides some bottom
  /// - Parameter consider: true / false
  /// - Returns: Modified View
  ///
  func considerSafeArea(_ consider: Bool) -> Self {
    var newView = self
    newView.considerSafeArea = consider
    return newView
  }
}
