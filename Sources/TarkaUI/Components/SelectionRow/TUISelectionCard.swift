//
//  TUISelectionCard.swift
//  
//
//  Created by MAHESHWARAN on 21/06/23.
//

import SwiftUI

/// `TUISelectionCard` is a  container view that displays title and description with selection color
///  This view can be used in any SwiftUI view.
///
/// Example usage:
///
///      TUISelectionCard(isSelected: true, showChevron: true) { }
///        .style([.textDescription("welcome")])
///        .badgeCount(24)
///        .badgeColor(.blue)
///        .icon(.chevronRight24Regular)
///
/// - Parameters:
///   - isSelected: This Bool is used to display the selection, The default selection color is `.surface`
///   - showChevron: This Bool is used to display chevronRight. The default value `false`.
///
/// - Returns: A closure that returns the content

public struct TUISelectionCard: View {
  
  private var isSelected: Bool
  private var icon: FluentIcon?
  private var style: [Style] = []
  private var badgeCount: Int = 0
  private var badgeColor: Color = .onTertiaryAlt
  private var showChevron: Bool
  private var action: (() -> Void)?
  
  public init(isSelected: Bool = false, showChevron: Bool = false,
              action: (() -> Void)? = nil) {
    self.isSelected = isSelected
    self.showChevron = showChevron
    self.action = action
  }
  
  public var body: some View {
    HStack(spacing: Spacing.baseHorizontal) {
      leftView
      rightView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, Spacing.baseHorizontal)
    .padding(.vertical, Spacing.custom(12))
    .background(isSelected ? Color.primaryAlt : Color.surface)
    .clipShape(RoundedRectangle(cornerRadius:Spacing.baseHorizontal))
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
    .onTapGesture {
      if let action { action() }
    }
  }
  
  public var leftView: some View {
    HStack(alignment: style.count <= 1 ? .center : .top, spacing: Spacing.baseHorizontal) {
      leftIconView
      leftDetailView
    }
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder
  private var leftIconView: some View {
    if let icon {
      Image(fluent: icon)
        .frame(width: 24, height: 24)
        .clipped()
        .foregroundColor(.secondaryTUI)
        .accessibilityIdentifier(Accessibility.leftIcon)
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder
  private var leftDetailView: some View {
    VStack(alignment: .leading, spacing: Spacing.halfVertical) {
      detailViews
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  @ViewBuilder
  private func titleView(
    for title: any StringProtocol,
    accessibilityID: TUISelectionCard.Accessibility = .title) -> some View {
      Text(title)
        .font(.body7)
        .foregroundColor(.inputTextDim)
        .frame(minHeight: Spacing.custom(18))
        .accessibilityIdentifier(accessibilityID)
    }
  
  @ViewBuilder
  private var detailViews: some View {
    ForEach(style, id: \.self) { style in
      switch style {
      case .onlyTitle(let title):
        titleView(for: title)
      case .textDescription(let desc):
        textDescriptionView(desc)
      case .footer(let footer):
        titleView(for: footer, accessibilityID: .footer)
      }
    }
  }
  
  @ViewBuilder
  private func textDescriptionView(
    _ description: String,
    accessibilityID: TUISelectionCard.Accessibility = .description) -> some View {
      Text(description)
        .font(.heading6)
        .foregroundColor(.onSurface)
        .frame(minHeight: Spacing.custom(18))
        .accessibilityIdentifier(accessibilityID)
    }
  
  @ViewBuilder
  private var rightView: some View {
    HStack(spacing: Spacing.quarterHorizontal) {
      if badgeCount > 0 {
        TUIBadge(
          style: .number(badgeCount),
          badgeColor: badgeColor,
          size: .size16)
          .accessibilityIdentifier(Accessibility.badge)
      }
      if showChevron {
        Image(fluent: .chevronRight24Regular)
          .frame(width: 24, height: 24)
          .clipped()
          .foregroundColor(isSelected ? .onSurface : .outline)
          .accessibilityIdentifier(Accessibility.chevron)
      }
    }
  }
}

public extension TUISelectionCard {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUISelectionCard"
    case title = "Title"
    case description = "Description"
    case footer = "footer_Description"
    case leftIcon = "leftIcon"
    case badge = "badge"
    case chevron = "chevronRight"
  }
  
  enum Style: Hashable {
    /// Displays only the title. with default fontColor `.inputTextDim`
    case onlyTitle(String)
    /// Display Description, with default fontColor `.onSurface`
    case textDescription(String)
    /// Display Footer
    case footer(String)
  }
  
  // MARK: - Modifiers
  
  func style(_ style: [TUISelectionCard.Style]) -> Self {
    var newView = self
    newView.style = style
    return newView
  }
  
  func badgeCount(_ badgeCount: Int) -> Self {
    var newView = self
    newView.badgeCount = badgeCount
    return newView
  }
  
  func badgeColor(_ badgeColor: Color) -> Self {
    var newView = self
    newView.badgeColor = badgeColor
    return newView
  }
  
  func icon(_ icon: FluentIcon) -> Self {
    var newView = self
    newView.icon = icon
    return newView
  }
}

struct TUISelectionRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TUISelectionCard()
        .style([.textDescription("Welcome")])
        .icon(.person24Regular)
      
      TUISelectionCard(isSelected: true)
        .style([.onlyTitle("Hello"), .textDescription("Welcome")])
        .icon(.person24Regular)
      
      TUISelectionCard(showChevron: true) {}
        .style([ .onlyTitle("Hello"), .textDescription("welcome"),
                 .textDescription("to"), .footer("SwiftUI")])
        .icon(.person24Regular)
        .badgeCount(3)
        .badgeColor(.green)
    }
  }
}
