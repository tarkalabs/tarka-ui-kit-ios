//
//  BottomMobileButtonBlock.swift
//
//
//  Created by Gopinath on 16/08/23.
//

import SwiftUI



// FIXME: - As we face issue in showing done button in toolbar in iOS 17.0 version,
// we pick the approach to show custom tool bar in safe area. It seems like a SwiftUI issue.
// Hence we need to regularly check the latest updates of SwiftUI for this issue fix
// and update this approach accordingly.

struct BottomMobileButtonBlock<T>: ViewModifier where T: View {
  
  @State var isKeyboardShown: Bool = false
  @State var showToolBar: Bool = false
  @State var additionalViewHeight: CGFloat = 0
  @State var canShowDoneButton = false
  @Binding var isDoneClicked: Bool
  
  var onClicked: (() -> Void)?
  
  var block: TUIMobileButtonBlock
  var additionalView: T
  var showAdditionalView = false
  var isButtonEnabled = true
  
  init(
    _ block: TUIMobileButtonBlock,
    additionalView: T,
    showAdditionalView: Bool = false,
    isButtonEnabled: Bool,
    isDoneClicked: Binding<Bool>?,
    onClicked: (() -> Void)? = nil) {
      
      self._isDoneClicked = isDoneClicked ?? .constant(false)
      self.onClicked = onClicked
      self.canShowDoneButton = (isDoneClicked != nil) || (onClicked != nil)
      self.block = block
      self.additionalView = additionalView
      self.showAdditionalView = showAdditionalView
      self.isButtonEnabled = isButtonEnabled
    }
  
  func body(content: Content) -> some View {
    
    GeometryReader { geometry in
      
      let safeAreaBottomInset = geometry.safeAreaInsets.bottom
      
      content.frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
          if isKeyboardShown {
            if showToolBar, canShowDoneButton {
              VStack(spacing: 0) {
                TUIDivider(orientation: .horizontal(hPadding: .zero, vPadding: .zero))
                  .frame(height: 1)
                HStack {
                  Spacer()
                  Button("Done".localized) {
                    showToolBar = false
                    isDoneClicked = true
                    onClicked?()
                  }
                  .padding(.vertical, Spacing.custom(10))
                  .padding(.trailing, Spacing.custom(20))
                }
                .background(Color.onSecondary)
              }
              // As toolbar is hiding textfield in the bottom by default,
              // we give extra padding for its visibility
              .padding(.top, Spacing.custom(20))
              .frame(maxWidth: .infinity)
            } else {
              EmptyView()
            }
          } else {
            VStack(spacing: 0) {
              if showAdditionalView {
                ZStack {
                  BackgroundBlur()
                  additionalView.getHeight($additionalViewHeight)
                }
                .background(Color.surface50)
                .frame(height: additionalViewHeight)
              }
              if isButtonEnabled {
                block
              }
              Color.surface.frame(height: safeAreaBottomInset)
            }
            .padding(.top, Spacing.halfVertical)
          }
        }
        .edgesIgnoringSafeArea(.bottom)
        .adaptiveKeyboard(isKeyboardShown: $isKeyboardShown)
        .onChange(of: isKeyboardShown) { newValue in
          if newValue {
            // Default animation to show toolbar makes conflict with keyboard display animation.
            // Hence we show toolbar in some delay to let keyboard to complete its animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              showToolBar = true
            }
          } else {
            showToolBar = false
          }
        }
    }
  }
}
