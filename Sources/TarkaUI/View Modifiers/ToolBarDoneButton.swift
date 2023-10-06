//
//  ToolBarDoneButton.swift
//  
//
//  Created by Gopinath on 09/08/23.
//

import SwiftUI

struct ToolBarDoneButton: ViewModifier {
  
  @Binding var isDoneClicked: Bool
  @State var isKeyboardShown: Bool = false
  
  var onClicked: (() -> Void)? = nil
  
  func body(content: Content) -> some View {
    
    content.frame(maxHeight: .infinity)
      .safeAreaInset(edge: .bottom) {
        EmptyView().frame(height: Spacing.baseVertical)
      }
      .adaptiveKeyboard(isKeyboardShown: $isKeyboardShown)
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          Button("Done".localized) {
            isDoneClicked = true
            onClicked?()
          }
        }
      }
  }
}

public extension View {
  /// Adds done button in toolbar
  /// - Parameter isDoneClicked: binding that handles when done button is clicked
  /// - Returns: View
  ///
  @ViewBuilder
  func addDoneButtonInToolbar(
    isDoneClicked: Binding<Bool>) -> some View {
      modifier(ToolBarDoneButton(isDoneClicked: isDoneClicked, onClicked: { }))
    }
  
  /// Adds done button in toolbar
  /// - Parameter onClicked: closure that called when done button is clicked
  /// - Returns: View
  ///
  @ViewBuilder
  func addDoneButtonInToolbar(
    onClicked: (() -> Void)? = nil) -> some View {
      modifier(ToolBarDoneButton(isDoneClicked: .constant(false), onClicked: onClicked))
    }
}
