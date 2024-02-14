//
//  BackgroundHalfTransparentView.swift
//
//
//  Created by Gopinath on 13/02/24.
//

import SwiftUI

/// A view with half transparent view added in its background
public struct BackgroundHalfTransparentView<ContentView: View>: ViewModifier {
  
  var isPresented: Bool
  var contentView: ContentView
  
  public init(
    isPresented: Bool,
    contentView: ContentView) {
      
      self.isPresented = isPresented
      self.contentView = contentView
    }
  
  public func body(content: Content) -> some View {
    ZStack {
      content
      if isPresented {
        Color.black.opacity(0.5)
          .frame(maxHeight: .infinity)
          .ignoresSafeArea()
        contentView
      }
    }
  }
}

