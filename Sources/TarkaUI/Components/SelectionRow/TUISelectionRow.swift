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
///   - isSelected: This Bool is used to display the selection, The default value is `.surface`
///
/// - Returns: A closure that returns the content

public struct TUISelectionRow<Content>: View where Content: View {
  
  var content: () -> Content
  
  public var isSelected: Bool
  
  public init(isSelected: Bool = false,
              @ViewBuilder content: @escaping () -> Content) {
    self.isSelected = isSelected
    self.content = content
  }
  
  public var body: some View {
    HStack {
      content()
    }
    .frame(maxWidth: .infinity)
    .padding(.leading)
    .padding(.vertical, Spacing.baseVertical)
    .background(isSelected ? Color.primaryAlt : Color.surface)
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
      TUISelectionRow(isSelected: true) {
        TUITextRow("Hello", style: .textDescription("Welcome"))
      }
    }
  }
}
