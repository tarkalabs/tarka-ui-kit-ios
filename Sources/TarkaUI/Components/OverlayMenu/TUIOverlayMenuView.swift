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
  @State private var buttonAction:  (() -> Void)?
  
  var padding: CGFloat = 16
  var verticalGap: CGFloat = 8

  private var title: String
  private var action: (() -> Void)?
  private var menuItems: [TUIMenuItemView]
  
  private var height: CGFloat {
    contentHeight + headerHeight + bottomViewHeight
  }
  
  public init(menuItems: [TUIMenuItemView],
              action: (() -> Void)? = nil) {
    self.init(title: "", menuItems: menuItems, action: action)
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
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
    .presentationDetents([.height(height)])
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
    .onDisappear(perform: performButtonAction)
  }
  
  // MARK: - Header View
  
  @ViewBuilder
  private var headerView: some View {
    
    let headerStyle: TUIOverlayHeaderView.Style = title.isEmpty ?
      .handle : .onlyTitle(title)
    
    TUIOverlayHeaderView(headerStyle)
      .accessibilityIdentifier(Accessibility.headerView)
      .accessibilityElement(children: .contain)
      .getHeight($headerHeight)
  }
  
  // MARK: - Menu Items View
  
  @ViewBuilder
  private var menuItemView: some View {
    if !menuItems.isEmpty {
      ScrollView {
        VStack(spacing: verticalGap) {
          ForEach(menuItems, id: \.item.id) { button in
            let index: Int = menuItems.firstIndex(where: { $0.item == button.item }) ?? 0
            TUIMenuItemView(item: button.item, isSelected: button.isSelected) {
              buttonAction = button.action
              dismiss()
            }
            .accessibilityIdentifier(
              Accessibility.menuItemRow(index))
          }
        }
        .padding(padding)
        .background(Color.surface)
        .getHeight($contentHeight)
      }
      .frame(maxHeight: contentHeight)
      .accessibilityIdentifier(Accessibility.menuItemView)
      .accessibilityElement(children: .contain)
    }
  }
  
  private func performButtonAction() {
    buttonAction?()
    buttonAction = nil
  }
  
  // MARK: - Bottom View
  
  private var bottomView: some View {
    TUIOverlayFooter {
      CancelButton(dismissAction)
    }
    .frame(maxWidth: .infinity)
    .onTapGesture(perform: dismissAction)
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
  
  private func dismissAction() {
    buttonAction = action
    dismiss()
  }
}

extension TUIOverlayMenuView {
  
  enum Accessibility: TUIAccessibility {
    case root
    case title
    case headerView
    case bottomView
    case menuItemView
    case menuItemRow(Int)
    
    var identifier: String {
      
      switch self {
      case .root: 
        return "TUIOverlayMenuView"
      case .title:
        return "Title"
      case .menuItemView:
        return "Menu Item View"
      case .headerView:
        return "HeaderView"
      case .bottomView:
        return "BottomView"
      case .menuItemRow(let row):
        return "MenuItemRow\(row)"
      }
    }
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
        .ignoresSafeArea()
      TUIOverlayMenuView(title: "Menu Title", menuItems: menuItems) {}
    }
  }
}
