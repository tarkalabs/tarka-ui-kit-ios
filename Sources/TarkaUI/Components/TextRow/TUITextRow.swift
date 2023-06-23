//
//  TUITextRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

/// `TUITextRow` is a SwiftUI view that displays a title and an optional description in a vertical stack.
/// The view can be customized with different styles, such as displaying only the title or displaying both the title and description.

public struct TUITextRow: View {
  public var title: any StringProtocol
  public var style: Style
  public var fontStyle: FontStyle = .primary
  
  @Environment(\.wrapperIcon) private var wrapperIcon
  @Environment(\.iconButton) private var iconButton
  
  /// Creates a text row with the specified title and style.
  ///
  /// - Parameters:
  ///   - title: The title to display in the text row.
  ///   - style: The style to use to display the text row. The default value is `.onlyTitle`.
  ///
  public init(_ title: any StringProtocol, style: TUITextRow.Style,
              fontStyle: TUITextRow.FontStyle = .primary) {
    self.title = title
    self.style = style
    self.fontStyle = fontStyle
  }
  
  public var body: some View {
    
    HStack(spacing: Spacing.halfHorizontal) {
      
      leftView
        .frame(maxWidth: .infinity, alignment: .leading)

      rightView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var leftView: some View {
    VStack(
      alignment: .leading,
      spacing: Spacing.halfVertical
    ) {
      Group {
        titleView
        detailView(forStyle: style)
      }
      .padding(.trailing, Spacing.halfHorizontal)
    }
  }
  
  @ViewBuilder
  private var titleView: some View {
    switch style {
    case .onlyTitle:
      Text(title)
        .font(.heading7)
        .foregroundColor(.onSurface)
        .frame(minHeight: 18)
        .padding(.vertical, Spacing.custom(11))
        .accessibilityIdentifier(Accessibility.title)
      
    default:
      Text(title)
        .font(.body8)
        .foregroundColor(fontStyle == .primary ? .inputTextDim : .onSurface)
        .frame(minHeight: 14)
        .accessibilityIdentifier(Accessibility.title)
    }
  }
  
  @ViewBuilder
  private func detailView(forStyle style: Style) -> some View {
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
      .foregroundColor(fontStyle == .primary ? .onSurface : .inputTextDim)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.description)
  }
  
  @ViewBuilder
  private var rightView: some View {

    HStack(spacing: Spacing.quarterHorizontal) {
      
      if iconButton.shouldShow {

        TUIIconButton(
          icon: iconButton.image,
          action: iconButton.action)
        .iconButtonStyle(.ghost)
        .iconButtonSize(.l)
      }

      if wrapperIcon.shouldShow {
        TUIWrapperIcon(image: wrapperIcon.image, color: wrapperIcon.color) {
          wrapperIcon.action()
        }
      }
    }
  }
}

public extension TUITextRow {
  enum Style {
    /// Displays only the title.
    case onlyTitle
    
    /// Displays the title and description.
    case textDescription(String)
  }
  
  enum FontStyle {
    case primary
    case custom
  }
}

extension TUITextRow {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUITextRow"
    case title = "Title"
    case description = "Description"
  }
}

struct TextRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 10) {
      Group {
        
        TUITextRow("Title", style: .onlyTitle)
          .previewDisplayName("Only Title")
          .iconButton(image: Symbol.warning) { }
        
        TUITextRow("Title", style: .textDescription("Description to test with multiple number of lines to verify its adaptability"))
          .previewDisplayName("With Text Description")
          .infoIcon(true) { }
      }
      TUITextRow("Title", style: .textDescription("Description"))
        .previewDisplayName("With Info Icon")
        .wrapperIcon(true, image: Symbol.chevronRight) { }
    }
  }
}
