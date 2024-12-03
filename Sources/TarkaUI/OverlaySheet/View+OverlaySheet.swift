//
//  View+OverlaySheet.swift
//
//
//  Created by MAHESHWARAN on 24/01/24.
//

import SwiftUI

public extension View {
  
  ///  Overlay  sheet
  ///
  /// Example usage:
  ///
  ///       Text("Hello")
  ///         .onTapGesture { showSheet.toggle() }
  ///         .overlaySheet(isPresented: $showSheet) {
  ///            SheetView()
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
  func overlaySheet<V: View>(isPresented: Binding<Bool>,
                             content: @autoclosure @escaping () -> V) -> some View {
    modifier(OverlaySheet(isPresented: isPresented, contentView: content()))
  }
}

