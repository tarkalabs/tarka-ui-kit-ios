//
//  TUIOverlayMenuView.swift
//  
//
//  Created by MAHESHWARAN on 22/08/23.
//

import SwiftUI

public struct TUIOverlayMenuView: View {
  @Environment(\.dismiss) private var dismiss
  
  private var title: String
  private var action: (() -> Void)?
  private var menuItems: [TUIMenuItemView]
  
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
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - Header View
  
  private var headerView: some View {
    TUIOverlayHeaderView(.onlyTitle(title))
      .customCornerRadius(Spacing.baseHorizontal)
      .accessibilityIdentifier(Accessibility.headerView)
      .accessibilityElement(children: .contain)
  }
  
  // MARK: - Menu Items View
  
  @ViewBuilder
  private var menuItemView: some View {
    if !menuItems.isEmpty {
      VStack(spacing: Spacing.custom(24)) {
        ForEach(menuItems, id: \.item.id) { item in
          item
        }
      }
      .padding(Spacing.custom(24))
      .background(Color.surface)
      .accessibilityIdentifier(Accessibility.menuItemView)
      .accessibilityElement(children: .contain)
    }
  }
  
  // MARK: - Bottom View
  
  private var bottomView: some View {
    TUIOverlayFooter {
      CancelButton {}
    }
    .frame(maxWidth: .infinity)
    .background(Color.surface)
    .onTapGesture(perform: dimissAction)
    .clipShape(RoundedCorner(radius: 16, corners: [.bottomLeft, .bottomRight]))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.bottomView)
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
    [.init(item: .init(title: "Hello", style: .onlyLabel), isSelected: true) {},
     .init(item: .init(title: "Welcome", style: .leftIcon(.accessTime20Filled))) {},
     .init(item: .init(title: "To", style: .statusDots(.circle12Filled, .success)), isSelected: true) {},
     .init(item: .init(title: "SwiftUI", style: .withRightIcon(.add24Filled, .dismiss24Filled))) {}
    ]
  }
  
  static var previews: some View {
    ZStack {
      Color.gray.opacity(0.3)
      TUIOverlayMenuView(title: "Title", menuItems: menuItems) {}
    }
    .ignoresSafeArea()
  }
}
