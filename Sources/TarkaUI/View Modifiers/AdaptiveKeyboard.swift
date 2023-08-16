//
//  AdaptiveKeyboard.swift
//
//
//  Created by Gopinath on 09/08/23.
//

import SwiftUI
import Combine

struct AdaptiveKeyboard: ViewModifier {
  
  @State var currentHeight: CGFloat = 0
  @Binding var isKeyboardShown: Bool
  
  func body(content: Content) -> some View {
    
    content
      .padding(.bottom, currentHeight)
      .onChange(of: currentHeight, perform: { newValue in
        isKeyboardShown = newValue > 0
      })
      .onAppear(
        perform: {
          
          NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillShowNotification)
          .merge(
            with: NotificationCenter.Publisher(
              center: .default,
              name: UIResponder.keyboardWillChangeFrameNotification))
          .compactMap { notification in
            withAnimation(.easeOut(duration: 0.16)) {
              notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
          }
          .map { _ in
            1
          }
          .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
          
          NotificationCenter.Publisher(
            center: .default,
            name: UIResponder.keyboardWillHideNotification)
          .compactMap { notification in
            CGFloat.zero
          }
          .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
        })
  }
}

public extension View {
  /// Makes the keyboard adaptive to the textfield
  /// - Returns: View
  ///
  @ViewBuilder
  func adaptiveKeyboard(isKeyboardShown: Binding<Bool>) -> some View {
    modifier(AdaptiveKeyboard(isKeyboardShown: isKeyboardShown))
  }
}


