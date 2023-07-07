//
//  TUIDraggableCard.swift
//  
//
//  Created by Arvindh Sukumar on 08/05/23.
//

import SwiftUI

/// A view that represents a draggable card with an icon button and content.
///
/// The `TUIDraggableCard` view is a container view that displays an icon button and content. The icon button can be used to trigger a drag gesture to move the card around. The content can be any SwiftUI view.
///
/// Example usage:
///
///     TUIDraggableCard {
///       HStack {
///         Text("Description")
///           .font(.heading6)
///           .foregroundColor(Color.inputText)
///
///         Spacer()
///       }
///     }
///
/// - Parameters:
///   - content: A closure that returns the content to display in the card.
///
/// - Returns: A view that represents a draggable card with an icon button and content.
public struct TUIDraggableCard<Content>: View where Content: View {
  var content: () -> Content
  
  /// Creates a draggable card with an icon button and content.
  ///
  /// - Parameters:
  ///   - content: A closure that returns the content to display in the card.
  ///
  public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }
  
  public var body: some View {
      HStack {
        TUIIconButton(icon: .reOrder24Regular) {
        }
        .padding(.horizontal, Spacing.halfHorizontal)
        // TODO: Add drag gesture to button
        
        content()
      }
      .background(Color.surface)
      .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct DraggableCard_Previews: PreviewProvider {
    static var previews: some View {
      TUIDraggableCard {
        HStack {
          Text("Description")
            .font(.heading6)
            .foregroundColor(Color.inputText)
          
          Spacer()
        }
      }
      .padding()
    }
}
