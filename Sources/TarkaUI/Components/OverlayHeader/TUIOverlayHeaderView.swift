//
//  TUIOverlayHeaderView.swift
//  
//
//  Created by MAHESHWARAN on 21/08/23.
//

import SwiftUI

public struct TUIOverlayHeaderView: View {
  
  private var style: Style
  
  private var radius: CGFloat = 0.0
  private var corners: UIRectCorner = .allCorners
  
  public init(_ style: TUIOverlayHeaderView.Style) {
    self.style = style
  }
  
  public var body: some View {
    mainView
      .accessibilityElement(children: .contain)
      .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var mainView: some View {
    switch style {
    case .handle:
      handleView
      
    case .onlyTitle(let title):
      onlyTitleView(title)
      
    case .left(let title, let action):
      leftView(title, action: action)
      
    case .right(let title, let icon, let action):
      rightView(title, icon: icon, action: action)
    }
  }
  
  // MARK: - Handle View
  
  private var handleView: some View {
    VStack(spacing: 0) {
      handle
        .padding(.top, Spacing.baseVertical)
        .padding(.bottom, Spacing.custom(12))
    }
    .frame(height: Spacing.custom(24))
    .frame(maxWidth: .infinity)
    .background(Color.surface)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - Only Title View
  
  private func onlyTitleView(_ title: String) -> some View {
    VStack(spacing: 0) {
      handle
        .padding(.vertical, Spacing.baseVertical)
      
      titleView(title)
        .padding(.bottom, Spacing.custom(21))
        .frame(maxWidth: .infinity)
      
      borderView
    }
    .frame(height: Spacing.custom(64))
    .frame(maxWidth: .infinity)
    .background(Color.surface)
    .customCorner(radius, corners: corners)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - Left View
  
  private func leftView(_ title: String, action: @escaping () -> Void) -> some View {
    VStack(spacing: 0) {
      handle
        .padding(.vertical, Spacing.baseVertical)
      
      titleView(title)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .leading) {
          buttonView(.chevronLeft24Regular, accessibility: .leftIcon, action: action)
        }
        .padding(.bottom, Spacing.custom(21))
      borderView
    }
    .frame(height: Spacing.custom(64))
    .frame(maxWidth: .infinity)
    .background(Color.surface)
    .customCorner(radius, corners: corners)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - Right View
  
  private func rightView(_ title: String, icon: FluentIcon,
                         action: @escaping () -> Void) -> some View {
    VStack(spacing: 0) {
      handle
        .padding(.vertical, Spacing.baseVertical)
      
      titleView(title)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .trailing) {
          buttonView(icon, action: action)
        }
        .padding(.bottom, Spacing.custom(21))
      borderView
    }
    .frame(height: Spacing.custom(64))
    .frame(maxWidth: .infinity)
    .background(Color.surface)
    .customCorner(radius, corners: corners)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - Views
  
  private var handle: some View {
    Rectangle()
      .fill(Color.surfaceVariant)
      .cornerRadius(Spacing.custom(45))
      .frame(width: Spacing.custom(68), height: Spacing.quarterHorizontal)
      .accessibilityIdentifier(Accessibility.handle)
  }
  
  private func titleView(_ title: String) -> some View {
    Text(title)
      .font(.heading5)
      .foregroundStyle(Color.onSurface)
      .frame(height: Spacing.custom(22), alignment: .leading)
      .padding(.horizontal, Spacing.baseHorizontal)
      .accessibilityIdentifier(Accessibility.title)
  }
  
  private var borderView: some View {
    TUIDivider(orientation: .horizontal(hPadding: .zero, vPadding: .zero))
  }
  
  private func buttonView(_ icon: FluentIcon,
                          accessibility id: Accessibility = .rightButton,
                          action: @escaping () -> Void) -> some View {
    TUIIconButton(icon: icon) {
      action()
    }
    .iconColor(.onSurface)
    .size(.size40)
    .accessibilityIdentifier(id)
  }
}

public extension TUIOverlayHeaderView {
  
  enum Style {
    case handle
    case onlyTitle(String)
    case left(String, action: () -> Void)
    case right(String, rightIcon: FluentIcon, action: () -> Void)
  }
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIOverlayHeaderView"
    case handle = "Handle"
    case title = "Title"
    case leftIcon = "LeftIcon"
    case rightButton = "RightButton"
  }
  
  func customCornerRadius(
    _ radius: CGFloat, corners: UIRectCorner = [.topLeft, .topRight]) -> Self {
      var newView = self
      newView.radius = radius
      newView.corners = corners
      return newView
    }
}

struct TUIOverlayHeaderView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.gray.opacity(0.2)
      
      VStack(spacing: 10) {
        TUIOverlayHeaderView(.handle)
        
        TUIOverlayHeaderView(.onlyTitle("Title"))
        
        TUIOverlayHeaderView(.left("Title") {})
        
        TUIOverlayHeaderView(.right("Title", rightIcon: .dismiss24Regular) {})
        
        TUIOverlayHeaderView(.onlyTitle("Title"))
          .customCornerRadius(16)
        
        TUIOverlayHeaderView(.left("Title") {})
          .customCornerRadius(16)
        
        TUIOverlayHeaderView(.right("Title", rightIcon: .dismiss24Regular) {})
          .customCornerRadius(16, corners: [.topLeft, .bottomRight])
        
        TUIOverlayHeaderView(.right("Title", rightIcon: .dismiss24Regular) {})
          .customCornerRadius(16, corners: .allCorners)
      }
      .padding()
    }
    .ignoresSafeArea()
  }
}
