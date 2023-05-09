//
//  DraggableCard.swift
//  
//
//  Created by Arvindh Sukumar on 08/05/23.
//

import SwiftUI

public struct DraggableCard<Content>: View where Content: View {
  var content: () -> Content
  
  public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }
  
  public var body: some View {
      HStack {
        IconButton(
          icon: .reorderDots
        ) {
          
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
      DraggableCard {
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
