//
//  TUIMobileOverlayHeader.swift
//
//
//  Created by MAHESHWARAN on 21/08/23.
//

import SwiftUI

public struct TUIMobileOverlayHeader: View {
  
  private var style: Style
  
  public init(_ style: TUIMobileOverlayHeader.Style) {
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
      
    case .rightWithMenu(let title, let icon, let menu):
      rightView(title, icon: icon, menu: menu)

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
    .accessibilityElement(children: .contain)
  }
  
  private func rightView(_ title: String, icon: FluentIcon,
                         menu: [TUIContextMenuSection]) -> some View {
    VStack(spacing: 0) {
      handle
        .padding(.vertical, Spacing.baseVertical)
      
      titleView(title)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .trailing) {
          buttonView(icon, menu: menu)
        }
        .padding(.bottom, Spacing.custom(21))
      borderView
    }
    .frame(height: Spacing.custom(64))
    .frame(maxWidth: .infinity)
    .background(Color.surface)
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
      .color(.surfaceVariantHover)
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
  
  private func buttonView(_ icon: FluentIcon,
                          accessibility id: Accessibility = .rightButton,
                          menu: [TUIContextMenuSection]) -> some View {
    TUIIconButton(icon: icon) {
    }
    .iconColor(.onSurface)
    .size(.size40)
    .menu(menu)
    .accessibilityIdentifier(id)
  }
}

public extension TUIMobileOverlayHeader {
  
  enum Style {
    case handle
    case onlyTitle(String)
    case left(String, action: () -> Void)
    case right(String, rightIcon: FluentIcon, action: () -> Void)
    case rightWithMenu(String, rightIcon: FluentIcon, menu: [TUIContextMenuSection])
  }
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIMobileOverlayHeader"
    case handle = "Handle"
    case title = "Title"
    case leftIcon = "LeftIcon"
    case rightButton = "RightButton"
  }
}

struct TUIOverlayHeaderView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.gray.opacity(0.2)
      
      VStack(spacing: 10) {
        TUIMobileOverlayHeader(.handle)
        
        TUIMobileOverlayHeader(.onlyTitle("Title"))
        
        TUIMobileOverlayHeader(.left("Title") {})
        
        TUIMobileOverlayHeader(.right("Title", rightIcon: .dismiss24Regular) {})
        
        TUIMobileOverlayHeader(.onlyTitle("Title"))
          .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
        TUIMobileOverlayHeader(.left("Title") {})
        
        TUIMobileOverlayHeader(.right("Title", rightIcon: .dismiss24Regular) {})
          .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
        
        TUIMobileOverlayHeader(.right("Title", rightIcon: .dismiss24Regular) {})
          .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
      }
      .padding()
    }
    .ignoresSafeArea()
  }
}
