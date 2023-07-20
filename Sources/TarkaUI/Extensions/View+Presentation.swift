//
//  View+Presentation.swift
//  
//
//  Created by Gopinath on 11/07/23.
//

import SwiftUI

extension View {
  @ViewBuilder
  func transparentBackground() -> some View {
    if #available(iOS 16.4, *) {
      self.presentationBackground(.black.opacity(0.5))
    } else {
      self.background(BackgroundClearView())
    }
  }
}
