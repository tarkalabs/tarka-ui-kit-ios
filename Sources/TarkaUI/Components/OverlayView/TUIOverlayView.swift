//
//  TUIOverlayView.swift
//
//
//  Created by MAHESHWARAN on 28/11/23.
//

import SwiftUI

public struct TUIOverlayView<Content: View>: View {
  @Environment(\.dismiss) private var dismiss
  
  @State private var contentHeight = CGFloat.zero
  @State private var headerHeight = CGFloat.zero
  @State private var bottomViewHeight = CGFloat.zero
  
  private var height: CGFloat {
    contentHeight + headerHeight + bottomViewHeight
  }
  
  public var content: Content
  public var headerViewStyle: TUIOverlayHeaderView.Style = .handle
  public var bottomViewStyle: BottomButtonStyle?
  
  public init(@ViewBuilder _ content: @escaping () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      headerView
      contentView
      bottomView
    }
    .background(Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
    .presentationDetents([.height(height)])
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - HeaderView
  
  private var headerView: some View {
    TUIOverlayHeaderView(headerViewStyle)
      .accessibilityIdentifier(Accessibility.headerView)
      .accessibilityElement(children: .contain)
      .getHeight($headerHeight)
  }
  
  // MARK: - Bottom View
  
  @ViewBuilder
  private var bottomView: some View {
    if let bottomViewStyle {
      TUIMobileButtonBlock(style: buttonBlockStyle(bottomViewStyle))
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(Accessibility.bottomView)
        .getHeight($bottomViewHeight)
    }
  }
  
  public func buttonBlockStyle(_ style: BottomButtonStyle) -> TUIMobileButtonBlock.Style {
    switch style {
    case .one(let title, let action):
      return .one(.init(title: title) { buttonAction(action) })
      
    case .two(let left, let leftAction, let right, let rightAction),
        .flexible(let left, let leftAction, let right, let rightAction):
      
      return .two(
        left: .init(title: left) {
          buttonAction(leftAction) },
        right: .init(title: right) {
          buttonAction(rightAction)
        })
    }
  }
  
  private func buttonAction(_ action: (() -> Void)? = nil) {
    dismiss()
    action?()
  }
  
  // MARK: - Content View
  
  private var contentView: some View {
    content
      .background(Color.surface)
      .getHeight($contentHeight)
      .accessibilityIdentifier(Accessibility.contentView)
      .accessibilityElement(children: .contain)
  }
}

public extension TUIOverlayView {
  
  enum BottomButtonStyle {
    case one(String, TUIButtonAction? = nil),
         two(left: String, TUIButtonAction? = nil,
             right: String, TUIButtonAction?),
         flexible(left: String, TUIButtonAction? = nil,
                  right: String, TUIButtonAction?)
  }
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIOverlayView"
    case contentView = "Menu Item View"
    case headerView = "HeaderView"
    case bottomView = "BottomView"
  }
  
  func headerStyle(_ style: TUIOverlayHeaderView.Style = .handle) -> Self {
    var newView = self
    newView.headerViewStyle = style
    return newView
  }
  
  func footerStyle(_ style: BottomButtonStyle) -> Self {
    var newView = self
    newView.bottomViewStyle = style
    return newView
  }
}

struct TUIOverlayView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.gray.opacity(0.3).ignoresSafeArea()
      
      TUIOverlayView {
        VStack {
          Image(systemName: "star")
            .resizable()
            .frame(width: 100, height: 100)
          Text("Hello")
        }
        .padding(20)
      }
      .headerStyle(.onlyTitle("Title"))
      .footerStyle(.two(left: "Cancel", right: "Done", { }))
      .padding()
    }
  }
}