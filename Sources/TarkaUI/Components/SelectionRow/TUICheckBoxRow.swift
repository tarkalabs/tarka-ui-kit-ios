//
//  TUICheckBoxRow.swift
//  
//
//  Created by MAHESHWARAN on 23/06/23.
//

import SwiftUI

/// `TUICheckBoxRow` is a  container view that displays any view with selection color
///  The content can be any SwiftUI view.
///
/// Example usage:
///
///     TUICheckBoxRow {
///       HStack {
///         Text("Description")
///           .foregroundColor(Color.surface)
///
///         Spacer()
///       }
///     }
///
/// - Parameters:
///   - isSelected: This Bool is used to display the checkBox selection,
///   - selectionStyle: This used to display the border, The default selectionStyle is `.plain`
///
/// - Returns: A closure that returns the content

public struct TUICheckBoxRow<Content>: View where Content: View {
  
  public var isSelected: Bool
  public var selectionStyle: SelectionStyle
  var content: () -> Content
  
  public init(isSelected: Bool = false,
              selectionStyle: SelectionStyle = .plain,
              @ViewBuilder content: @escaping () -> Content) {
    self.selectionStyle = selectionStyle
    self.isSelected = isSelected
    self.content = content
  }
  
  public var body: some View {
    HStack(spacing: Spacing.baseHorizontal) {
      leftView
      content()
    }
    .frame(maxWidth: .infinity)
    .padding(.leading, Spacing.halfHorizontal)
    .padding(.vertical, Spacing.baseVertical)
    .background(selectionStyle == .border ? Color.surfaceHover : Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
  }
  
  @ViewBuilder
  private var leftView: some View {
    Image(isSelected ? Symbol.checkBoxChecked : Symbol.checkBoxUnChecked)
      .foregroundColor(isSelected ? .primaryTUI : .outline)
  }
}

public extension TUICheckBoxRow  {
  
  enum SelectionStyle {
    case plain, border
  }
}

struct TUICheckBoxRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 20) {
      TUICheckBoxRow(isSelected: true, selectionStyle: .border) {
        TUITextRow("Title", style: .textDescription("Welcome"))
      }
      TUICheckBoxRow {
        TUITextRow("Title", style: .onlyTitle)
      }
    }
  }
}
