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
  @Environment(\.colorScheme) private var colorScheme
  private var title: any StringProtocol
  private var style: Style = .onlyTitle
  private var titleFont: Font = .heading7
  private var titleColor: Color = .onSurface
  
  private var isSelected: Bool
  private var borderStyle: BorderStyle = .plain

  public init(_ title: any StringProtocol, isSelected: Bool = false) {
    self.title = title
    self.isSelected = isSelected
  }
  
  public var body: some View {
    HStack(alignment: style == .onlyTitle ? .center : .top,
           spacing: Spacing.baseHorizontal) {
      leftView
      rightView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(Spacing.halfHorizontal)
    .background(borderStyle == .border ? Color.surfaceHover : Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var leftView: some View {
    let imageName = isSelected ? "checkbox_checked" :
    colorScheme == .dark ? "checkbox-dark-unchecked" :  "checkbox_unchecked"
    Image(imageName, bundle: Bundle.module)
      .scaledToFit()
      .frame(width: 24, height: 24)
      .clipped()
  }
  
  @ViewBuilder
  private var rightView: some View {
    VStack(alignment: .leading, spacing: Spacing.halfVertical) {
      switch style {
      case .onlyTitle:
        titleView
        
      case .textDescription(let desc):
        titleView
        textDescriptionView(desc)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var titleView: some View {
    Text(title)
      .font(titleFont)
      .foregroundColor(titleColor)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.title)
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
  
  enum BorderStyle {
    case plain, border
  }
  
  enum Style: Equatable {
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
  
  // MARK: - Modifiers
  
  func style(_ style: TUICheckBoxRow.Style) -> Self {
    var newView = self
    newView.style = style
    return newView
  }
  
  func borderStyle(_ style: BorderStyle) -> Self {
    var newView = self
    newView.borderStyle = style
    return newView
  }
  
  func titleStyle(_ font: TUIFont, textColor: Color = .onSurface) -> Self {
    var newView = self
    newView.titleFont = Font.using(font)
    newView.titleColor = textColor
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
