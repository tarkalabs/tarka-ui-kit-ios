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
  
  /// Creates a menu item view.
  ///
  /// - Parameters:
  ///   - item: The `TUIMenuItem` to display.
  ///   - action: The action to perform when the menu item is tapped.
  ///
  public init(item: TUIMenuItem, action: @escaping () -> Void) {
    self.item = item
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
    .buttonStyle(MenuItemStyle())
  }
  
  @ViewBuilder
  private var leftContentView: some View {
    switch item.configuration {
    case .withIcon(let fluentIcon):
      Image(fluent: fluentIcon)
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
    case .onlyLabel, .withIcon:
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
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(configuration.isPressed ? Color.surfaceHover : Color.clear)
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}

struct MenuItemView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TUIMenuItemView(
        item: TUIMenuItem(
          title: "Label",
          configuration: .withIcon(.reOrder24Regular)
        ),
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
