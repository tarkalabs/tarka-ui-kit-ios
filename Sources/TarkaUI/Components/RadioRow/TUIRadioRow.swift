//
//  TUIRadioRow.swift
//
//
//  Created by MAHESHWARAN on 02/02/24.
//

import SwiftUI

public struct TUIRadioRow: View {
  
  private var itemItem: InputItem

  public init(_ title: String, isSelected: Bool = false) {
    itemItem = .init(title: title, isSelected: isSelected)
  }
  
  public var body: some View {
    HStack(alignment: itemItem.style == .onlyTitle ? .center : .top,
           spacing: Spacing.baseHorizontal) {
      leftView
      rightView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(Spacing.halfHorizontal)
    .background(itemItem.borderStyle == .border ? Color.surfaceHover : Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var leftView: some View {
    TUIRadioButton()
      .style(itemItem.isSelected ? .selected : .unSelected)
  }
  
  @ViewBuilder
  private var rightView: some View {
    VStack(alignment: .leading, spacing: Spacing.halfVertical) {
      switch itemItem.style {
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
    Text(itemItem.title)
      .font(itemItem.titleFont)
      .foregroundColor(itemItem.titleColor)
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

// MARK: - InputItem

extension TUIRadioRow {
  
  struct InputItem {
    var title: String
    var style: Style = .onlyTitle
    var titleFont: Font = .heading7
    var titleColor: Color = .onSurface
    
    var isSelected: Bool
    var borderStyle: BorderStyle = .plain
  }
}

// MARK: - Style

public extension TUIRadioRow  {
  
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
    case root = "TUIRadioRow"
    case title = "Title"
    case description = "Description"
  }
  
  // MARK: - Modifiers
  
  func style(_ style: TUIRadioRow.Style) -> Self {
    var newView = self
    newView.itemItem.style = style
    return newView
  }
  
  func borderStyle(_ style: BorderStyle) -> Self {
    var newView = self
    newView.itemItem.borderStyle = style
    return newView
  }
  
  func titleStyle(_ font: TUIFont, textColor: Color = .onSurface) -> Self {
    var newView = self
    newView.itemItem.titleFont = Font.using(font)
    newView.itemItem.titleColor = textColor
    return newView
  }
}

// MARK: - Preview

struct TUIRadioRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 20) {
      TUIRadioRow("Hello")
        .borderStyle(.border)
      
      TUIRadioRow("Welcome", isSelected: true)
        .style(.textDescription("SwiftUI"))
        .borderStyle(.plain)
    }
  }
}
