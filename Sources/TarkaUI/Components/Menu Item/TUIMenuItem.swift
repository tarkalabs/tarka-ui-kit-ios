//
//  TUIMenuItem.swift
//
//
//  Created by Arvindh Sukumar on 27/04/23.
//

import SwiftUI

public struct TUIMenuItem: View {
  public var item: TUIMenuItemProperties
  public var action: () -> Void
  public var isSelected: Bool
  
  /// Creates a menu item view.
  ///
  /// - Parameters:
  ///   - item: The `TUIMenuItemProperties` to display.
  ///   - isSelected: This bool is used to display selection color
  ///   - action: The action to perform when the menu item is tapped.
  ///
  public init(item: TUIMenuItemProperties, isSelected: Bool = false,
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
      .frame(maxWidth: .infinity, minHeight: item.style.height(isSelected), alignment: .leading)
      .contentShape(Rectangle())
    }
    .buttonStyle(TUIMenuItemButtonStyle(item.style.isEnabled(isSelected)))
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder
  private var detailView: some View {
    switch item.style {
    case .onlyLabel:
      if isSelected {
        checkmarkView
      }
      titleView
      
    case .leftImage(let image):
      leftImageView(image)
      titleView
      if isSelected {
        checkmarkView
      }
      
    case .withRightIcon(let leftIcon, let rightIcon):
      leftImageView(Image(fluent: leftIcon))
      titleView
      rightIconView(rightIcon)
      
    case .rightIcon(let icon):
      titleView
      rightIconView(icon)
      
    case .statusDots(let icon, let color):
      statusDotView(icon, color: color)
      titleView
      if isSelected {
        checkmarkView
      }
      
    case .withDescription(let desc):
      descriptionView(desc)
    }
  }
  
  @ViewBuilder
  private var titleView: some View {
    Text(item.title)
      .font(.body7)
      .foregroundColor(.onSurface)
      .frame(maxWidth: .infinity, minHeight: Spacing.custom(18), alignment: .leading)
  }
  
  @ViewBuilder
  private func descriptionView(_ desc: String) -> some View {
    VStack(alignment: .leading, spacing: Spacing.custom(0)) {
      Text(item.title)
        .font(.heading7)
        .foregroundColor(.onSurface)
        .frame(maxWidth: .infinity, minHeight: Spacing.custom(20), alignment: .leading)
        .accessibilityIdentifier(Accessibility.title)
      
      Text(desc)
        .font(.body6)
        .foregroundColor(.onSurface)
        .frame(maxWidth: .infinity, minHeight: Spacing.custom(20), alignment: .leading)
        .accessibilityIdentifier(Accessibility.description)
    }
    .frame(minHeight: Spacing.custom(42), alignment: .leading)
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder
  private var checkmarkView: some View {
    Image(fluent: .checkmark24Regular)
      .foregroundColor(.success)
      .frame(width: Spacing.custom(24), height: Spacing.custom(24))
      .accessibilityIdentifier(Accessibility.checkmark)
  }
  
  private func leftImageView(_ image: Image) -> some View {
    image
      .scaledToFill()
      .frame(width: Spacing.custom(24), height: Spacing.custom(24))
      .accessibilityIdentifier(Accessibility.leftIcon)
  }
  
  private func rightIconView(_ icon: FluentIcon) -> some View {
    Image(fluent: icon)
      .scaledToFill()
      .frame(width: Spacing.custom(20), height: Spacing.custom(20))
      .foregroundColor(.outline)
      .accessibilityIdentifier(Accessibility.rightIcon)
  }
  
  private func statusDotView(_ icon: FluentIcon, color: Color) -> some View {
    Image(fluent: icon)
      .scaledToFill()
      .frame(minWidth: Spacing.custom(16), minHeight: Spacing.custom(16))
      .foregroundColor(color)
      .accessibilityIdentifier(Accessibility.leftIcon)
  }
  
  struct TUIMenuItemButtonStyle: ButtonStyle {
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
      if isSelected {
        return isPressed ? Color.success20 : .success10
      } else {
        return isPressed ? .surfaceHover.opacity(0.8) : .clear
      }
    }
  }
}

public extension TUIMenuItem {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIMenuItem"
    case title = "Title"
    case description = "Description"
    case leftIcon = "leftIcon"
    case rightIcon = "rightIcon"
    case checkmark = "checkmark"
    case chevron = "chevronRight"
  }
}

struct MenuItemView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 20) {
      TUIMenuItem(item: TUIMenuItemProperties(title: "Label", style: .onlyLabel)) { }
      
      TUIMenuItem(item: TUIMenuItemProperties(title: "Label is selected", style: .onlyLabel),
                      isSelected: true) { }
      
      TUIMenuItem(item:
          .init(
            title: "Left Icon",
            style: .leftImage(Image(fluent:.add24Filled)))) { }
      
      TUIMenuItem(
        item: .init(
          title: "Left Icon is selected",
          style: .leftImage(Image(fluent: .add24Filled))),
        isSelected: true) { }
      
      
      TUIMenuItem(item: TUIMenuItemProperties(title: "Label with left and Right Icon",
                                        style: .withRightIcon(.add24Filled, .chevronRight20Filled))) {}
      
      TUIMenuItem(item: TUIMenuItemProperties(title: "Label with left and Right Icon",
                                        style: .rightIcon(.chevronRight20Filled))) {}
      
      TUIMenuItem(item: TUIMenuItemProperties(title: "Status Dots",
                                        style: .statusDots(.circle16Filled, .success))) {}
      
      TUIMenuItem(item: TUIMenuItemProperties(title: "Status Dots",
                                        style: .statusDots(.circle16Filled, .success)), isSelected: true) {}
      
      TUIMenuItem(item: TUIMenuItemProperties(title: "Label", style: .withDescription("Description"))) {}
    }
    .padding(.horizontal, 10)
    .previewLayout(.sizeThatFits)
  }
}
