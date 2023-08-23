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
  private var bottomSafeAreaInset: CGFloat = 0
  
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
    .isEnabled(bottomSafeAreaInset > 0, content: { view in
      // It reduces the unexpected extra blur effect that overlays on the button
      VStack(spacing: Spacing.custom(10)) {
        view
        BackgroundBlur(radius: blurRadius)
          .frame(maxWidth: .infinity)
      }
    })
    .frame(maxWidth: .infinity)
  }
  
  private var minHeight: CGFloat {
    return 80 + bottomSafeAreaInset
  }
  
  private var buttonBottomPadding: CGFloat {
    guard bottomSafeAreaInset > 0 else {
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
  func addSafeAreaBottomInset(_ value: CGFloat) -> Self {
    var newView = self
    newView.bottomSafeAreaInset = value
    return newView
  }
}
