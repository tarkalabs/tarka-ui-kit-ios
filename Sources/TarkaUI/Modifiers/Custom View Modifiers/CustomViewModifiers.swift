//
//  TUIOverlayHeaderView.swift
//  
//
//  Created by Gopinath on 09/08/23.
//

import SwiftUI

struct ToolBarDoneButton: ViewModifier {
  
  @Binding var isDoneClicked: Bool
  var onClicked: (() -> Void)? = nil

  func body(content: Content) -> some View {
    
    content.toolbar {
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
