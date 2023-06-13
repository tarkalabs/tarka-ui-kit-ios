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
  
  @ObservedObject var wrapperIcon: IconButtonItem<TUIWrapperIcon> = IconButtonItem()
  
  @ObservedObject var iconButton: IconButtonItem<TUIIconButton> = IconButtonItem()

  /// Creates a text row with the specified title and style.
  ///
  /// - Parameters:
  ///   - title: The title to display in the text row.
  ///   - style: The style to use to display the text row. The default value is `.onlyTitle`.
  ///
  public init(_ title: any StringProtocol, style: TUITextRow.Style) {
    self.title = title
    self.style = style
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
        .foregroundColor(.inputTextDim)
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
      .foregroundColor(.onSurface)
      .frame(minHeight: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.description)
  }
  
  @ViewBuilder
  private var rightView: some View {

    HStack(spacing: Spacing.quarterHorizontal) {
      
      if iconButton.shouldShow {

        iconButton.icon
        .iconButtonSize(.l)
      }

      if wrapperIcon.shouldShow {
        wrapperIcon.icon
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

        TUITextRow("Title", style: .textDescription("Description to test with multiple number of lines to verify its adaptability"))
        .wrapperInfoIcon { }
          .previewDisplayName("With Text Description")

      TUITextRow("Title", style: .textDescription("Description"))
        .wrapperIcon {
          TUIWrapperIcon(image: Symbol.warning) { }
            .iconColor(.black)
        }
        .previewDisplayName("With Info Icon")
    }
  }
}
