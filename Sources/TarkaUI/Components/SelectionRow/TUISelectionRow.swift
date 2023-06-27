//
//  TUISelectionRow.swift
//  
//
//  Created by MAHESHWARAN on 21/06/23.
//

import SwiftUI

/// `TUISelectionRow` is a  container view that displays title and description with selection color
///  This view can be used in any SwiftUI view.
///
/// Example usage:
///
///      TUISelectionRow("Hello", style: .textDescription("SwiftUI", forTitle: .onSurface),
///      icon: Symbol.person, isSelected: true, badgeCount: 4) { }
///
/// - Parameters:
///   - isSelected: This Bool is used to display the selection, The default selection color is `.surface`
///   - title: The title to display in the text row.
///   - style: The style to use to display the text row and title font Color. The default value is `.onlyTitle`.
///   - icon: This is used to display the icon.
///   - badgeCount: This is used to show the badge count.
///   - badgeColor: This is used to show custom badgeColor, The default value is `.onTertiaryAlt`
///
/// - Returns: A closure that returns the content action

public struct TUISelectionRow: View {
  
  public var isSelected: Bool
  public var icon: Icon?
  public var title: any StringProtocol
  public var style: Style
  public var badgeCount: Int
  public var badgeColor: Color
  public var action: (() -> Void)?
  
  public init(_ title: any StringProtocol,
              style: TUISelectionRow.Style,
              icon: Icon? = nil,
              isSelected: Bool = false,
              badgeCount: Int = 0,
              badgeColor: Color = .onTertiaryAlt,
              action: (() -> Void)? = nil) {
    self.isSelected = isSelected
    self.title = title
    self.style = style
    self.icon = icon
    self.badgeCount = badgeCount
    self.badgeColor = badgeColor
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
    .onTapGesture {
      if let action { action() }
    }
  }
  
  public var leftView: some View {
    HStack(alignment: style == .onlyTitle ? .center : .top, spacing: Spacing.baseHorizontal) {
      leftIconView
      leftDetailView
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.leftView)
  }
  
  @ViewBuilder
  private var leftIconView: some View {
    if let icon {
      Image(icon)
        .foregroundColor(.secondaryTUI)
        .accessibilityIdentifier(Accessibility.leftIcon)
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder
  private var leftDetailView: some View {
    VStack(alignment: .leading, spacing: Spacing.halfVertical) {
      detailView(forStyle: style)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  @ViewBuilder
  private func titleView(for title: any StringProtocol,
                         color: Color = .inputTextDim,
                         accessibilityID: TUISelectionRow.Accessibility = .title) -> some View {
    Text(title)
      .font(color == .inputTextDim ? .body7 : .heading6)
      .foregroundColor(color)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(accessibilityID)
  }
  
  @ViewBuilder
  private func detailView(forStyle style: Style) -> some View {
    switch style {
    case .onlyTitle:
      titleView(for: title, color: .onSurface)
    case .textDescription(let desc, let titleColor):
      titleView(for: title, color: titleColor == .inputTextDim ? .onSurface : .inputTextDim)
      textDescriptionView(desc, color: titleColor ?? .onSurface)
    case .withFooterDescription(let header, let desc, let footer):
      titleView(for: title)
      textDescriptionView(header)
      textDescriptionView(desc, accessibilityID: .subDescription)
      if let footer {
        titleView(for: footer, accessibilityID: .footer)
      }
    }
  }
  
  @ViewBuilder
  private func textDescriptionView(_ description: String, color: Color = .onSurface,
                                   accessibilityID: TUISelectionRow.Accessibility = .description) -> some View {
    Text(description)
      .font(color == .onSurface ? .heading6 : .body7)
      .foregroundColor(color)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(accessibilityID)
  }
  
  @ViewBuilder
  private var rightView: some View {
    HStack(spacing: Spacing.quarterHorizontal) {
      if badgeCount > 0 {
        TUIBadge(count: badgeCount, badgeColor: badgeColor)
          .badgeSize(.m)
          .accessibilityIdentifier(Accessibility.badge)
      }
      if let action {
        TUIIconButton(icon: Symbol.chevronRight, action: action)
          .iconButtonStyle(.ghost)
          .accessibilityIdentifier(Accessibility.chevron)
      }
    }
  }
}

public extension TUISelectionRow {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUISelectionRow"
    case title = "Title"
    case description = "Description"
    case subDescription = "subDescription"
    case footer = "footer_Description"
    case leftIcon = "leftIcon"
    case leftView = "leftView"
    case badge = "badge"
    case chevron = "chevronRight"
  }
  
  enum Style: Equatable {
    /// Displays only the title.
    case onlyTitle
    /// Displays the title and description, with custom title font color, default `onSurface`
    case textDescription(String, fontColor: Color? = .onSurface)
    /// Displays  title, subTitle, description, with optional footer
    case withFooterDescription(_ header: String, desc: String, footer: String? = nil)
  }
}

struct TUISelectionRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TUISelectionRow("Hello", style: .onlyTitle, isSelected: true)
      TUISelectionRow("Hello", style: .textDescription("SwiftUI", fontColor: .onSurface),
                      icon: Symbol.person, badgeCount: 4) {}
      TUISelectionRow("Hello", style: .textDescription("Welcome"), isSelected: true)
      TUISelectionRow("Hello", style: .textDescription("SwiftUI", fontColor: .inputTextDim))
      
      TUISelectionRow("Hello", style: .withFooterDescription("welcome", desc: "to", footer: "SwiftUI"),
                      icon: Symbol.person, isSelected: true, badgeCount: 4) {}
    }
  }
}
