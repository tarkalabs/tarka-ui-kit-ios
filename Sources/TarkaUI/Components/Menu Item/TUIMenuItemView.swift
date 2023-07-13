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
      HStack(spacing: 0) {
        leftContentView
        contentView
        rightContentView
      }
      .padding(.vertical, Spacing.baseVertical)
      .frame(maxWidth: .infinity, alignment: .leading)
      .contentShape(Rectangle())
    }
    .buttonStyle(MenuItemStyle(isSelected))
  }
  
  @ViewBuilder
  private var leftContentView: some View {
    switch item.configuration {
    case .withSymbol(let symbol):
      Image(fluent: symbol)
        .scaledToFill()
        .frame(width: 24, height: 24)
        .padding(.leading, Spacing.baseHorizontal)
        .padding(.trailing, Spacing.halfHorizontal)
        .clipped()
    default:
      Spacer()
        .frame(width: 48)
    }
  }
  
  @ViewBuilder
  private var contentView: some View {
    switch item.configuration {
    case .onlyLabel, .withSymbol:
      Text(item.title)
        .font(.body7)
        .foregroundColor(.onSurface)
    case .withDescription(let desc):
      VStack(alignment: .leading, spacing: Spacing.custom(2)) {
        Text(item.title)
          .font(.heading6)
          .foregroundColor(.onSurface)
        Text(desc)
          .font(.body6)
          .foregroundColor(.onSurface)
      }
    }
  }
  
  @ViewBuilder
  private var rightContentView: some View {
    // TODO: Implement this
    EmptyView()
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
    Group {
      TUIMenuItemView(
        item: TUIMenuItem(
          title: "Label",
          configuration: .withSymbol(.reOrder24Regular)
        ),
        isSelected: true,
        action: {}
      )
    
      TUIMenuItemView(
        item: TUIMenuItem(
          title: "Label",
          configuration: .onlyLabel
        ),
        action: {}
      )
      
      TUIMenuItemView(
        item: TUIMenuItem(
          title: "Label",
          configuration: .withDescription("Description")
        ),
        action: {}
      )
    }
    .previewLayout(.sizeThatFits)
  }
}
