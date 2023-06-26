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
///     TUICheckBoxRow("Hello", style: .onlyTitle, isSelected: true, selectionStyle: .border)
///
/// - Parameters:
///   - isSelected: This Bool is used to display the checkBox selection,
///   - selectionStyle: This used to display the border, The default selectionStyle is `.plain`
///
/// - Returns: A closure that returns the content

public struct TUICheckBoxRow: View {
  
  public var title: any StringProtocol
  public var style: Style
  public var isSelected: Bool
  public var selectionStyle: SelectionStyle
  
  public init(_ title: any StringProtocol, style: TUICheckBoxRow.Style,
              isSelected: Bool = false,
              selectionStyle: SelectionStyle = .plain) {
    self.title = title
    self.style = style
    self.selectionStyle = selectionStyle
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
    .background(selectionStyle == .border ? Color.surfaceHover : Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
  }
  
  @ViewBuilder
  private var leftView: some View {
    Image(isSelected ? Symbol.checkBoxChecked : Symbol.checkBoxUnChecked)
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
    Text(title)
      .font(.heading7)
      .foregroundColor(.onSurface)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private func detailView(forStyle style: TUICheckBoxRow.Style) -> some View {
    switch style {
    case .onlyTitle:
      EmptyView()
    case .textDescription(let desc):
      textDescriptionView(desc)
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
}

public extension TUICheckBoxRow  {
  
  enum SelectionStyle {
    case plain, border
  }
  
  enum Style {
    /// Displays only the title.
    case onlyTitle
    
    /// Displays the title and description.
    case textDescription(String)
  }
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUITextRow"
    case title = "Title"
    case description = "Description"
  }
}

struct TUICheckBoxRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 20) {
      TUICheckBoxRow("Welcome", style: .textDescription("SwiftUI"))
      TUICheckBoxRow("Hello", style: .onlyTitle, isSelected: true, selectionStyle: .border)
    }
  }
}
