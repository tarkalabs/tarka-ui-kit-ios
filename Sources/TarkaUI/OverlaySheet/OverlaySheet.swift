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
  private var contentView: V
  
  public init(isPresented: Binding<Bool>, @ViewBuilder contentView: () -> V) {
    _isPresented = isPresented
    self.contentView = contentView()
  }
  
  public func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        contentView
          .backgroundView(withColor: sizeClass == .compact ? .surface : .clear) {
            isPresented = false
          }
      }
  }
}

public extension View {
  
  ///  Overlay  sheet
  ///
  /// Example usage:
  ///
  ///       Text("Hello")
  ///         .onTapGesture { showSheet.toggle }
  ///         .overlaySheet(isPresented: $showSheet) {
  ///             SheetView()
  ///         }
  ///
  ///         struct SheetView: view {
  ///           @State private var height = CGFloat.zero
  ///
  ///           var body: some View {
  ///             Text("ShowSheet")
  ///             .getHeight($height)
  ///             .presentationDetents([.height(height)])
  ///           }
  ///         }
  ///
  /// - Parameters:
  ///   - isPresented: to show / dismiss
  ///   - content: This can be any swiftUI view that has to be presented
  /// - Returns: View
  ///
  @ViewBuilder
  func overlaySheet<V: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> V) -> some View {
    modifier(OverlaySheet(isPresented: isPresented, contentView: content))
  }
}


