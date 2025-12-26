//
//  ToolBarDoneButton.swift
//  
//
//  Created by Gopinath on 09/08/23.
//

import SwiftUI

public final class ToolbarState: ObservableObject {
  @Published public var isEnabled = false
  public init() { }
}

struct ToolBarDoneButton: ViewModifier {
  @EnvironmentObject private var toolbarState: ToolbarState

  @Binding var isDoneClicked: Bool
  
  var onClicked: (() -> Void)? = nil
  
  func body(content: Content) -> some View {
    
    content.frame(maxHeight: .infinity)
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          Button("Done".localized) {
            isDoneClicked = true
            onClicked?()
          }
          .foregroundStyle(Color.primaryTUI)
          .onAppear {
              toolbarState.isEnabled = true
          }
          .onDisappear {
            toolbarState.isEnabled = false
          }
        }
      }
      .scrollDismissesKeyboard(.immediately)
  }
}

