//
//  TUICheckBoxRow.swift
//  
//
//  Created by MAHESHWARAN on 23/06/23.
//

import SwiftUI

/// `TUICheckBoxRow` is a  container view that displays checkbox with title and description.
///
/// Example usage:
///
///     TUICheckBoxRow("Hello", isSelected: true)
///       .style(.textDescription("SwiftUI"))
///       .borderStyle(.border)
///
/// - Parameters:
///   - title: This used to display the title
///   - isSelected: This Bool is used to display the checkBox selection,
///
/// - Returns: A closure that returns the content

public struct TUICheckBoxRow: View {
  
  private var title: any StringProtocol
  private var style: Style = .onlyTitle
  private var isSelected: Bool
  private var borderStyle: BorderStyle = .plain
  private var backgroundColor: Color = Color.surfaceHover

  public init(_ title: any StringProtocol, isSelected: Bool = false) {
    self.title = title
    self.isSelected = isSelected
  }
  
  public var body: some View {
    HStack(spacing: Spacing.baseHorizontal) {
      leftView
      rightView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, Spacing.halfHorizontal)
    .padding(.vertical, Spacing.baseVertical)
    .background(backgroundColor)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var leftView: some View {
    Image(fluent: isSelected ? .checkboxChecked24Filled : .checkboxUnchecked24Filled)
      .frame(width: 24, height: 24)
      .clipped()
      .foregroundColor(isSelected ? .primaryTUI : .outline)
  }
  
  @ViewBuilder
  private var rightView: some View {
    VStack(alignment: .leading, spacing: Spacing.halfVertical) {
      Group {
        titleView
        detailView(forStyle: style)
      }
    }
  }
  
  @ViewBuilder
  private var titleView: some View {
    switch style {
    case .onlyDescription:
      EmptyView()
    default:
      Text(title)
        .font(.heading7)
        .foregroundColor(.onSurface)
        .frame(minHeight: Spacing.custom(18))
        .accessibilityIdentifier(Accessibility.title)
    }    
  }
  
  @ViewBuilder
  private func detailView(forStyle style: TUICheckBoxRow.Style) -> some View {
    switch style {
    case .onlyTitle:
      EmptyView()
    case .textDescription(let desc):
      textDescriptionView(desc)
    case .onlyDescription(let desc):
      onlyDescriptionView(desc)
    }
  }
  
  @ViewBuilder
  private func textDescriptionView(_ description: String) -> some View {
    Text(description)
      .font(.body7)
      .foregroundColor(.inputTextDim)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.description)
  }
  
  @ViewBuilder
  private func onlyDescriptionView(_ description: String) -> some View {
    Text(description)
      .font(.body7)
      .foregroundColor(.onSurface)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.description)
  }
}

public extension TUICheckBoxRow  {
  
  enum BorderStyle {
    case plain, border
  }
  
  enum Style {
    /// Displays only the title.
    case onlyTitle
    
    /// Displays only the description.
    case onlyDescription(String)
    
    /// Displays the title and description.
    case textDescription(String)
  }
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUITextRow"
    case title = "Title"
    case description = "Description"
  }
  
  // MARK: - Modifiers
  
  func style(_ style: TUICheckBoxRow.Style) -> Self {
    var newView = self
    newView.style = style
    return newView
  }
  
  func borderStyle(_ style: BorderStyle) -> Self {
    var newView = self
    newView.borderStyle = style
    // Need to ask @Maheshwaran about color change
    if newView.backgroundColor == Color.surfaceHover ||
        newView.backgroundColor == Color.surface {
      newView.backgroundColor = borderStyle == .border ? Color.surfaceHover : Color.surface
    }
    return newView
  }
  
  func backgroundColor(_ color: Color) -> Self {
    var newView = self
    newView.backgroundColor = color
    return newView
  }
}

struct TUICheckBoxRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 20) {
      TUICheckBoxRow("Hello")
        .borderStyle(.border)
      
      TUICheckBoxRow("Welcome", isSelected: true)
        .style(.textDescription("SwiftUI"))
        .borderStyle(.plain)
    }
  }
}
