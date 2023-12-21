//
//  TUIContentUnavailableView.swift
//  
//
//  Created by MAHESHWARAN on 31/07/23.
//

import SwiftUI

public struct TUIContentUnavailableView: View {
  
  var title: any StringProtocol
  var icon: FluentIcon
  
  public init(_ title: any StringProtocol, icon: FluentIcon) {
    self.title = title
    self.icon = icon
  }
  
  public var body: some View {
    ZStack {
      Color.background
      contentView
    }
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder
  private var contentView: some View {
    VStack(spacing: Spacing.doubleVertical) {
      iconView
      titleView
    }
    .padding(.horizontal, Spacing.custom(32))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.contentView)
  }
  
  @ViewBuilder
  private var titleView: some View {
    Text(title)
      .font(.body5)
      .frame(minHeight: Spacing.custom(22))
      .multilineTextAlignment(.center)
      .foregroundStyle(Color.outline)
      .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private var iconView: some View {
    Image(fluent: icon)
      .foregroundStyle(Color.outline)
      .frame(minWidth: Spacing.baseHorizontal, minHeight: Spacing.doubleVertical)
      .accessibilityIdentifier(Accessibility.icon)
  }
}

public extension TUIContentUnavailableView {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIContentUnavailableView"
    case contentView = "contentView"
    case title = "Title"
    case icon = "Icon"
  }
}

struct TUIContentUnavailableView_Previews: PreviewProvider {
  static var previews: some View {
    TUIContentUnavailableView("Hello Welcome to swiftUI",
                              icon: .person48Filled)
  }
}
