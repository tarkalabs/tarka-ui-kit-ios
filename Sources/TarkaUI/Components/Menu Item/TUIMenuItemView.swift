//
//  TUIMenuItemView.swift
//
//
//  Created by Arvindh Sukumar on 27/04/23.
//

import SwiftUI

public struct TUIMenuItemView: View {
  public var item: TUIMenuItem
  public var action: () -> Void
  private var isSelected: Bool
  
  /// Creates a menu item view.
  ///
  /// - Parameters:
  ///   - item: The `TUIMenuItem` to display.
  ///   - action: The action to perform when the menu item is tapped.
  ///
  public init(item: TUIMenuItem, isSelected: Bool = false,
              action: @escaping () -> Void) {
    self.item = item
    self.isSelected = isSelected
    self.action = action
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      HStack(spacing: Spacing.halfHorizontal) {
        detailView
      }
      .padding(.vertical, item.style.vertical(isSelected))
      .padding(.leading, item.style.leading(isSelected))
      .padding(.trailing, item.style.trailing(isSelected))
      .frame(maxWidth: .infinity, alignment: .leading)
      .contentShape(Rectangle())
    }
    .buttonStyle(MenuItemStyle(isSelected))
  }
  
  @ViewBuilder
  private var detailView: some View {
    switch item.style {
    case .onlyLabel:
      if isSelected {
        checkmarkView
      }
      titleView
      
    case .leftIcon(let icon):
      leftIconView(icon)
      titleView
      if isSelected {
        checkmarkView
      }
      
    case .withRightIcon(let leftIcon, let rightIcon):
      leftIconView(leftIcon)
      titleView
      rightIconView(rightIcon)
      
    case .rightIcon(let icon):
      titleView
      rightIconView(icon)
      
    case .withDescription(let desc):
      descriptionView(desc)
    }
  }
  
  @ViewBuilder
  private var titleView: some View {
    Text(item.title)
      .font(.body7)
      .foregroundColor(.onSurface)
      .frame(maxWidth: .infinity, maxHeight: Spacing.custom(18), alignment: .topLeading)
  }
  
  @ViewBuilder
  private func descriptionView(_ desc: String) -> some View {
    VStack(alignment: .leading, spacing: Spacing.custom(0)) {
      Text(item.title)
        .font(.heading7)
        .foregroundColor(.onSurface)
        .frame(maxWidth: .infinity, maxHeight: Spacing.custom(20), alignment: .topLeading)
      
      Text(desc)
        .font(.body6)
        .foregroundColor(.onSurface)
        .frame(maxWidth: .infinity, maxHeight: Spacing.custom(20), alignment: .topLeading)
    }
  }
  
  @ViewBuilder
  private var checkmarkView: some View {
    Image(fluent: .checkmark24Regular)
      .foregroundColor(.success)
      .frame(maxWidth: Spacing.custom(24), maxHeight: Spacing.custom(24))
  }
  
  private func leftIconView(_ icon: FluentIcon) -> some View {
    Image(fluent: icon)
      .scaledToFill()
      .frame(width: Spacing.custom(24), height: Spacing.custom(24))
  }
  
  private func rightIconView(_ icon: FluentIcon) -> some View {
    Image(fluent: icon)
      .scaledToFill()
      .frame(width: Spacing.custom(20), height: Spacing.custom(20))
      .foregroundColor(.outline)
  }
}

struct MenuItemStyle: ButtonStyle {
  var isSelected: Bool = false
  
  init(_ isSelected: Bool) {
    self.isSelected = isSelected
  }
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(backgroundColor(configuration.isPressed))
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
  
  func backgroundColor(_ isPressed: Bool) -> Color {
    return isSelected ? .success.opacity(isPressed ? 0.2 : 0.1)  : isPressed ? .surfaceHover : .clear
  }
}

struct MenuItemView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TUIMenuItemView(item: TUIMenuItem(title: "Label", style: .onlyLabel)) { }
      
      TUIMenuItemView(item: TUIMenuItem(title: "Label is selected", style: .onlyLabel),
                      isSelected: true) { }
      
      TUIMenuItemView(item: .init(title: "Left Icon", style: .leftIcon(.add24Filled))) { }
      
      TUIMenuItemView(item: .init(title: "Left Icon is selected", style: .leftIcon(.add24Filled)),
                      isSelected: true) { }
      
      
      TUIMenuItemView(item: TUIMenuItem(title: "Label with left and Right Icon",
                                        style: .withRightIcon(.add24Filled, .chevronRight24Filled))) {}
      
      TUIMenuItemView(item: TUIMenuItem(title: "Label with left and Right Icon",
                                        style: .withRightIcon(.add24Filled, .chevronRight24Filled))) {}
      
      TUIMenuItemView(item: TUIMenuItem(title: "Label", style: .withDescription("Description"))) {}
    }
    .previewLayout(.sizeThatFits)
  }
}
