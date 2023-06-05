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
  
  @Environment(\.detailDisclosure) private var showDetailDisclosure
  
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
    HStack {
      VStack(
        alignment: .leading,
        spacing: Spacing.baseVertical
      ) {
          titleView
          detailView(forStyle: style)
      }
      
      if showDetailDisclosure {
        Spacer()
        
        TUIDetailDisclosure()
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var titleView: some View {
    switch style {
    case .onlyTitle:
      Text(title)
        .font(.heading7)
        .foregroundColor(.onSurface)
        .accessibilityIdentifier(Accessibility.title)
    default:
      Text(title)
        .font(.body8)
        .foregroundColor(.inputTextDim)
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
      .accessibilityIdentifier(Accessibility.description)
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
    Group {
      TUITextRow("Title", style: .onlyTitle)
        .previewDisplayName("Only Title")
      TUITextRow("Title", style: .textDescription("Description"))
        .previewDisplayName("With Text Description")
    }
    .detailDisclosure()
  }
}
