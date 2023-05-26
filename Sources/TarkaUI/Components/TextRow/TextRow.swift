//
//  TextRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

/// `TextRow` is a SwiftUI view that displays a title and an optional description in a vertical stack.
/// The view can be customized with different styles, such as displaying only the title or displaying both the title and description.
public struct TextRow: View {
  public var title: any StringProtocol
  public var style: Style
  
  @Environment(\.detailDisclosure) private var showDetailDisclosure
  
  /// Creates a text row with the specified title and style.
  ///
  /// - Parameters:
  ///   - title: The title to display in the text row.
  ///   - style: The style to use to display the text row. The default value is `.onlyTitle`.
  ///
  public init(_ title: any StringProtocol, style: TextRow.Style) {
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
  }
  
  @ViewBuilder
  private var titleView: some View {
    switch style {
    case .onlyTitle:
      Text(title)
        .font(.heading7)
        .foregroundColor(.onSurface)
    default:
      Text(title)
        .font(.body8)
        .foregroundColor(.inputTextDim)
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
  }
}

public extension TextRow {
  enum Style {
    /// Displays only the title.
    case onlyTitle

    /// Displays the title and description.
    case textDescription(String)
  }
}

struct TextRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TextRow("Title", style: .onlyTitle)
        .previewDisplayName("Only Title")
      TextRow("Title", style: .textDescription("Description"))
        .previewDisplayName("With Text Description")
    }
    .detailDisclosure()
  }
}
