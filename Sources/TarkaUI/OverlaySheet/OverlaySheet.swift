//
//  OverlaySheet.swift
//
//
//  Created by MAHESHWARAN on 22/09/23.
//

import SwiftUI

/// A View Modifier that shows overlay view as popup on iPad(when not in split screen) and
/// as bottom sheet on iPhones
public struct OverlaySheet<V: View>: ViewModifier {
  
  @Binding var isPresented: Bool
  @Environment(\.horizontalSizeClass) var sizeClass
  private var contentView: () -> V
  
  public init(isPresented: Binding<Bool>, contentView: @autoclosure @escaping () -> V) {
    _isPresented = isPresented
    self.contentView = contentView
  }
  
  public func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        DestinationView(
          isPresented: $isPresented,
          contentView: contentView,
          sizeClass: sizeClass)
      }
  }
  
  struct DestinationView: View {
    
    @Binding var isPresented: Bool
    var contentView: () -> V
    var sizeClass: UserInterfaceSizeClass?
    
    var body: some View {
      contentView()
        .backgroundView(withColor: sizeClass == .compact ? .surface : .clear) {
          isPresented = false
        }
    }
  }
}


