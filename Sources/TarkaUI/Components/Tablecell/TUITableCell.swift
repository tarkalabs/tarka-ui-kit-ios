//
//  TUITableCell.swift
//
//
//  Created by Gopinath on 29/11/23.
//

import SwiftUI

public struct TUITableCell: View {
  
  var borderStyle: TUITableCell.BorderStyle = .none
  var title: String
  var isHeader = false

  public init(title: String) {
    self.title = title
  }
  
  public var body: some View {
    Text(title)
      .foregroundStyle(
        isHeader ? Color.disabledContent : Color.onSurface)
      .font(.body7)
      .frame(minHeight: Spacing.custom(56))
      .background(Color.clear)
      .frame(maxWidth: .infinity, alignment: .leading)
      .border(
        width: 1, edges: borderStyle.edges,
        color: Color.surfaceVariantHover)
      .accessibilityIdentifier(Accessibility.root)
  }
}

public extension TUITableCell {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUITableCell"
  }
  
  enum BorderStyle {
    case top, bottom, topAndBottom, `none`
    
    var edges: [Edge] {
      switch self {
      case .top: return [.top]
      case .bottom: return [.bottom]
      case .topAndBottom: return [.top, .bottom]
      case .`none`: return []
      }
    }
  }
}

struct TUITableCell_Previews: PreviewProvider {
  
  static var previews: some View {
    TUITableCell(title: "Label")
      .borderStyle(.bottom)
      .isHeader(true)
  }
}
