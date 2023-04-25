//
//  TextRow.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

public struct TextRow: View {
  public var title: any StringProtocol
  public var style: Style
  
  public init(_ title: any StringProtocol, style: TextRow.Style) {
    self.title = title
    self.style = style
  }
  
  public var body: some View {
    VStack(
      alignment: .leading,
      spacing: Spacing.baseVertical
    ) {
        titleView
        detailView(forStyle: style)
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
    case onlyTitle
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
  }
}
