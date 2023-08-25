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
  private var hasSafeArea: Bool = false
  
  public init(style: Style) {
    self.style = style
  }
  
  private let fixedWidth: CGFloat = 342
  private let blurRadius: CGFloat = 7
  
  public var body: some View {
    
      VStack(spacing: Spacing.custom(15)) {
        
        TUIDivider(
          orientation: .horizontal(
            hPadding: .zero, vPadding: .zero))
        
        buttonBlock
      }
      .isEnabled(hasSafeArea, content: { view in
        // It assigns the blur for safe area portion
        view.safeAreaInset(edge: .bottom) {
          BackgroundBlur(radius: blurRadius)
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.bottom)
        }
      })
      .background(Color.surface50)
      .background() {
        // It assigns the blur for button block
        BackgroundBlur(radius: blurRadius)
          .frame(maxWidth: .infinity)
        // this solves the blur issue at the bottom of the safe area
          .edgesIgnoringSafeArea(.bottom)
      }
    .frame(minHeight: minHeight)
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
          .size(.large)
          .width(.maximum(fixedWidth))
        
      case .two(let left, let right):
        left
          .style(.outlined)
          .size(.large)
          .width(.maximum(.infinity))
          .accessibilityIdentifier(Accessibility.leftButton)
        right
          .style(.primary)
          .size(.large)
          .width(.maximum(.infinity))
          .accessibilityIdentifier(Accessibility.rightButton)
        
      case .flexible(let left, let right):
        left
          .style(.outlined)
          .size(.large)
          .accessibilityIdentifier(Accessibility.leftButton)
        right
          .style(.primary)
          .size(.large)
          .width(.maximum(fixedWidth))
          .accessibilityIdentifier(Accessibility.rightButton)
      }
    }
    .padding(.horizontal, Spacing.custom(24))
    .padding(.bottom, buttonBottomPadding)
    .frame(maxWidth: .infinity)
  }
  
  private var minHeight: CGFloat {
    guard hasSafeArea else {
      return 80 - buttonBottomPadding
    }
    return 80
  }
  
  private var buttonBottomPadding: CGFloat {
    guard hasSafeArea else {
      return Spacing.doubleVertical
    }
    return 0
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

public extension TUIMobileButtonBlock {
  
  /// Manually handles bototm safe area inset by adding more bottom space and
  /// adding extra blur layer for that extra added space
  /// - Parameter value: bottom value that to be added
  /// - Returns: Modified View
  ///
  func hasSafeArea(_ hasSafeArea: Bool) -> Self {
    var newView = self
    newView.hasSafeArea = hasSafeArea
    return newView
  }
}
