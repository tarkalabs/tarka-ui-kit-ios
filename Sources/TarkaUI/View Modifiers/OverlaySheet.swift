//
//  OverlaySheet.swift
//
//
//  Created by MAHESHWARAN on 21/09/23.
//

import SwiftUI

public extension View {
  
  func overlaySheet<V: View>(
    isPresented: Binding<Bool>,
    sheetBackgroundColor: Color = .clear,
    @ViewBuilder content: @escaping () -> V) -> some View {
      
      self.sheet(isPresented: isPresented) {
        content()
          .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
          .backgroundView(withColor: sheetBackgroundColor) {
            isPresented.wrappedValue = false
          }
      }
    }
}
