//
//  TUISelectionRow.swift
//  
//
//  Created by MAHESHWARAN on 21/06/23.
//

import SwiftUI

/// `TUISelectionRow` is a  container view that displays a title and an optional description,
///  The view can be used to trigger a tap gesture which provides the selected row as call back.
///
///  Example usage:
///
///  `TUISelectionRow("Title", style: .textDescription("Description")) { -> tapAction }
///

public struct TUISelectionRow: View {
  
  public var title: any StringProtocol
  public var style: TUITextRow.Style
  public var selectionColor: Color
  public var action: () -> Void
  
  /// Creates a selection row with the specified title and style.
  ///
  /// - Parameters:
  ///   - title: The title to display in the text row.
  ///   - style: The style to use to display the text row. The default value is `.onlyTitle`.
  ///   - selectionColor: This color used to display the selection, The default value is `.surface`
  ///   - action: This action used to pass the row tap action to view.
  public init(_ title: any StringProtocol, style: TUITextRow.Style,
              selectionColor: Color = .surface, action: @escaping () -> Void) {
    self.title = title
    self.style = style
    self.action = action
    self.selectionColor = selectionColor
  }
  
  public var body: some View {
    selectionView
      .frame(maxWidth: .infinity, alignment: .leading)
      .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var selectionView: some View {
    TUITextRow(title, style: style)
      .padding(.leading)
      .padding(.vertical, Spacing.baseVertical)
      .background(roundedRectangleView)
      .accessibilityIdentifier(Accessibility.title)
      .listRowSeparator(.hidden)
      .listRowBackground(Color.clear)
      .listRowInsets(EdgeInsets(
        top: Spacing.halfVertical,
        leading: Spacing.halfHorizontal,
        bottom: Spacing.halfVertical,
        trailing: Spacing.halfHorizontal))
  }
  
  @ViewBuilder
  private var roundedRectangleView: some View {
    RoundedRectangle(cornerRadius: Spacing.baseHorizontal)
      .background(.clear)
      .foregroundColor(selectionColor)
      .onTapGesture { action() }
  }
}

extension TUISelectionRow {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUISelectionRow"
    case title = "Title and Description"
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TUISelectionRow("Title", style: .textDescription("Description")) {}
      TUISelectionRow("Welcome to SwiftUI", style: .onlyTitle, selectionColor: .primaryAlt) { }
    }
  }
}
