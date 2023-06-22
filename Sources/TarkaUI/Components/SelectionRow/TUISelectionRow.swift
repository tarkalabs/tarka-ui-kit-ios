//
//  TUISelectionRow.swift
//  
//
//  Created by MAHESHWARAN on 21/06/23.
//

import SwiftUI

/// `TUISelectionRow` is a  container view that displays any view with selection color
///  The content can be any SwiftUI view.
///
/// Example usage:
///
///     TUISelectionRow {
///       HStack {
///         Image(Symbol.map)
///         Text("Description")
///           .foregroundColor(Color.surface)
///
///         Spacer()
///       }
///     }
///
/// - Parameters:
///   - selectionColor: This color used to display the selection, The default value is `.surface`
///
/// - Returns: A closure that returns the content

public struct TUISelectionRow<Content>: View where Content: View {
  
  var content: () -> Content
  
  public var selectionColor: Color
  
  public init(selectionColor: Color = .surface,
              @ViewBuilder content: @escaping () -> Content) {
    self.selectionColor = selectionColor
    self.content = content
  }
  
  public var body: some View {
    HStack {
      content()
    }
    .padding()
    .background(selectionColor)
    .clipShape(RoundedRectangle(cornerRadius:Spacing.baseHorizontal))
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUISelectionRow {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUISelectionRow"
  }
}

struct TUISelectionRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TUISelectionRow {
        TUITextRow("Hello", style: .textDescription("Welcome"))
      }
      TUISelectionRow(selectionColor: .primaryAlt) {
        TUITextRow("Hello", style: .textDescription("Welcome"))
      }
    }
  }
}
