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
///   - badgeColor: This is used to show custom badgeColor, The default value is `.tertiary`
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
              badgeColor: Color = .tertiary,
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
    .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private var leftIconView: some View {
    if let icon {
      Image(icon)
        .foregroundColor(.secondary)
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
                         color: Color = .inputTextDim) -> some View {
    Text(title)
      .font(color == .inputTextDim ? .body7 : .heading6)
      .foregroundColor(color)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private func detailView(forStyle style: Style) -> some View {
    switch style {
    case .onlyTitle:
      titleView(for: title, color: .onSurface)
    case .textDescription(let desc, let titleColor):
      titleView(for: title, color: titleColor ?? .onSurface)
      textDescriptionView(desc, color: titleColor == .onSurface ? .inputTextDim : .onSurface)
    }
  }
  
  @ViewBuilder
  private func textDescriptionView(_ description: String, color: Color = .onSurface) -> some View {
    Text(description)
      .font(color == .onSurface ? .heading6 : .body7)
      .foregroundColor(color)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.description)
  }
  
  @ViewBuilder
  private var rightView: some View {
    HStack(spacing: Spacing.quarterHorizontal) {
      if badgeCount > 0 {
        TUIBadge(count: badgeCount, badgeColor: badgeColor)
          .badgeSize(.m)
      }
      if let action {
        TUIIconButton(icon: Symbol.chevronRight, action: action)
          .iconButtonStyle(.ghost)
      }
    }
  }
}

public extension TUISelectionRow {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUISelectionRow"
    case title = "Title"
    case description = "Footer_Description"
  }
  
  enum Style: Equatable {
    /// Displays only the title.
    case onlyTitle
    /// Displays the title and description, with custom title font color, default `inputTextDim`
    case textDescription(String, forTitle: Color? = .inputTextDim)
  }
}

struct TUISelectionRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TUISelectionRow("Hello", style: .onlyTitle, isSelected: true)
      TUISelectionRow("Hello", style: .textDescription("SwiftUI",forTitle: .onSurface),
                      icon: Symbol.person, badgeCount: 4) {}
      TUISelectionRow("Hello", style: .textDescription("Welcome"), isSelected: true)
      TUISelectionRow("Hello", style: .textDescription("SwiftUI", forTitle: .onSurface))
    }
  }
}
