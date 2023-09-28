//
//  OverlayMenuSheet.swift
//
//
//  Created by Gopinath on 20/09/23.
//

import SwiftUI


/// A View Modifier that shows overlay menu as popup on iPad(when not in split screen) and
/// as bottom sheet on iPhones
public struct OverlayMenuSheet: ViewModifier {
  
  @Binding var isSheetPresented: Bool
  @State private var overlayMenuViewHeight: CGFloat = 0
  @State private var overlayMenuViewWidth: CGFloat = 0
  @State private var contentWidth: CGFloat = 0
  @State private var verticalPosition = 0.0
  var overlayMenuView: TUIOverlayMenuView
  
  public init(
    isSheetPresented: Binding<Bool>,
    @ViewBuilder overlayMenuView: () -> TUIOverlayMenuView) {
      self._isSheetPresented = isSheetPresented
      self.overlayMenuView = overlayMenuView()
    }
  
  public func body(content: Content) -> some View {
    
    let viewWidth = keyWindow?.bounds.width ?? contentWidth
    let color: Color =  viewWidth > overlayMenuViewWidth ? .clear : .surface
    ZStack {
      content
        .getWidth($contentWidth)
        .sheet(
          isPresented: $isSheetPresented,
          content: {
            overlayMenuView
              .getHeight($overlayMenuViewHeight)
              .getWidth($overlayMenuViewWidth)
              .backgroundView(withColor: color) {
                isSheetPresented = false
              }
              .presentationDetents([.height(overlayMenuViewHeight)])
          })
    }
  }
}

public extension View {
  
  @ViewBuilder
  /// Adds overlay menu sheet
  /// - Parameters:
  ///   - isSheetPresented: to show / dismiss
  ///   - overlayMenuView: Overlay menu view that has to be presented
  /// - Returns: View
  /// 
  func addOverlayMenuSheet(
    isSheetPresented: Binding<Bool>,
    @ViewBuilder overlayMenuView: () -> TUIOverlayMenuView) -> some View {
      modifier(OverlayMenuSheet(
        isSheetPresented: isSheetPresented,
        overlayMenuView: overlayMenuView))
    }
}
