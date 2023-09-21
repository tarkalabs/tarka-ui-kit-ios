//
//  TUIOverlayMenuView.swift
//  
//
//  Created by MAHESHWARAN on 22/08/23.
//

import SwiftUI

public struct TUIOverlayMenuView: View {
  @Environment(\.dismiss) private var dismiss
  
  @State private var contentHeight = CGFloat.zero
  @State private var headerHeight = CGFloat.zero
  @State private var bottomViewHeight = CGFloat.zero
  
  private var title: String
  private var action: (() -> Void)?
  private var menuItems: [TUIMenuItemView]
  
  private var height: CGFloat {
    contentHeight + headerHeight + bottomViewHeight
  }
  
  public init(title: String, menuItems: [TUIMenuItemView],
              action: (() -> Void)? = nil) {
    self.title = title
    self.action = action
    self.menuItems = menuItems
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      headerView
      menuItemView
      bottomView
    }
    .background(Color.surface)
    .presentationDetents([.height(height)])
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - Header View
  
  private var headerView: some View {
    TUIOverlayHeaderView(.onlyTitle(title))
      .setRadiusToCorners(Spacing.baseHorizontal, corners: .allCorners)
      .accessibilityIdentifier(Accessibility.headerView)
      .accessibilityElement(children: .contain)
      .getHeight($headerHeight)
  }
  
  // MARK: - Menu Items View
  
  @ViewBuilder
  private var menuItemView: some View {
    if !menuItems.isEmpty {
      ScrollView {
        VStack(spacing: Spacing.custom(24)) {
          ForEach(menuItems, id: \.item.id) { button in
            TUIMenuItemView(item: button.item, isSelected: button.isSelected) {
              dimissAction()
              button.action()
            }
          }
        }
        .padding(Spacing.custom(24))
        .background(Color.surface)
        .getHeight($contentHeight)
      }
      .frame(maxHeight: contentHeight)
      .accessibilityIdentifier(Accessibility.menuItemView)
      .accessibilityElement(children: .contain)
    }
  }
  
  // MARK: - Bottom View
  
  private var bottomView: some View {
    TUIOverlayFooter {
      CancelButton(dimissAction)
    }
    .frame(maxWidth: .infinity)
    .onTapGesture(perform: dimissAction)
    .clipShape(RoundedCorner(radius: 16, corners: [.bottomLeft, .bottomRight]))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.bottomView)
    .getHeight($bottomViewHeight)
  }
  
  private struct CancelButton: TUIOverlayFooterAction {
    
    var id: String { icon.resourceString }
    var icon: TarkaUI.FluentIcon { .dismiss24Regular }
    var handler: () -> Void
    
    init(_ handler: @escaping () -> Void) {
      self.handler = handler
    }
  }
  
  private func dimissAction() {
    if let action {
      action()
    } else {
      dismiss()
    }
  }
}

public extension TUIOverlayMenuView {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIOverlayMenuView"
    case title = "Title"
    case menuItemView = "Menu Item View"
    case headerView = "HeaderView"
    case bottomView = "BottomView"
  }
}

struct TUIOverlayMenuView_Previews: PreviewProvider {
  
  static var menuItems: [TUIMenuItemView] {
    (0...4).map { index in
      TUIMenuItemView(
        item: .init(title: index%2 == 0 ? "Hello" : "Welcome to swift",
                    style: index%2 == 0 ? .withRightIcon(.add24Filled, .dismiss24Filled):
            .leftIcon(.circle12Filled)),
        isSelected: (index%4) == 1,
        action: {})
    }
  }
  
  static var previews: some View {
    ZStack {
      Color.gray.opacity(0.3)
        .ignoresSafeArea()
      TUIOverlayMenuView(title: "Menu Title", menuItems: menuItems) {}
    }
  }
}
