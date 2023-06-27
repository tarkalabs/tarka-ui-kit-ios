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
///      TUISelectionRow("Hello", isSelected: true)
///        .style(.withFooterDescription("welcome", desc: "to", footer: "SwiftUI"))
///        .badgeCount(24)
///        .badgeColor(.blue)
///        .iconImage(Symbol.person)
///        .action {}
///
/// - Parameters:
///   - isSelected: This Bool is used to display the selection, The default selection color is `.surface`
///   - title: The title to display in the text row.
///
/// - Returns: A closure that returns the content action

public struct TUISelectionRow: View {
  
  private var isSelected: Bool
  private var icon: Icon?
  private var title: any StringProtocol
  private var style: Style = .onlyTitle
  private var badgeCount: Int = 0
  private var badgeColor: Color = .onTertiaryAlt
  private var showChevron: Bool = false
  private var action: (() -> Void)?
  
  public init(_ title: any StringProtocol, isSelected: Bool = false) {
    self.isSelected = isSelected
    self.title = title
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
    HStack(alignment: style == .onlyTitle ? .center : .top,
           spacing: Spacing.baseHorizontal) {
      leftIconView
      leftDetailView
    }
    .accessibilityElement(children: .contain)
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
  private func titleView(
    for title: any StringProtocol,
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
  private func textDescriptionView(
    _ description: String, color: Color = .onSurface,
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
      if showChevron {
        Image(systemName: "chevron.right")
          .foregroundColor(isSelected ? .onSurface : .outline)
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
    case badge = "badge"
    case chevron = "chevronRight"
  }
  
  enum Style: Equatable {
    /// Displays only the title.
    case onlyTitle
    /// Displays the title and description, with custom title font color, default `onSurface`
    case textDescription(_ desc: String, fontColor: Color? = .onSurface)
    /// Displays  title, subTitle, description, with optional footer
    case withFooterDescription(_ header: String, desc: String, footer: String? = nil)
  }
  
  // MARK: - Modifiers
  
  func style(_ style: TUISelectionRow.Style) -> Self {
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
  
  func action(_ show: Bool = true, _ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.action = action
    newView.showChevron = show
    return newView
  }
  
  func iconImage(_ icon: Icon) -> Self {
    var newView = self
    newView.icon = icon
    return newView
  }
}

struct TUISelectionRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TUISelectionRow("Hello")
      TUISelectionRow("Hello", isSelected: true)
        .style(.textDescription("Welcome"))
        .iconImage(Symbol.person)
      
      TUISelectionRow("Example")
        .style(.textDescription("for subHeading", fontColor: .inputTextDim))
      
      TUISelectionRow("Hello", isSelected: true)
        .style(.withFooterDescription("welcome", desc: "to", footer: "SwiftUI"))
        .badgeCount(24)
        .badgeColor(.blue)
        .iconImage(Symbol.person)
        .action {}
    }
  }
}
