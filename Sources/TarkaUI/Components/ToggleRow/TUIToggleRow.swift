//
//  TUIToggleRow.swift
//
//
//  Created by Arvindh Sukumar on 21/02/24.
//

import SwiftUI

/// A row with a content view and a toggle switch
/// - Parameters:
/// - contentView: The content view to be displayed
/// - toggle: The toggle switch to be displayed
struct TUIToggleRow<Content: View>: View {
  public var contentView: () -> Content
  public var toggle: () -> TUIToggleSwitch
  
  var body: some View {
    HStack {
      contentView()
      Spacer()
      toggle()
    }
    .padding(.vertical, Spacing.custom(11))
    .padding(.horizontal, Spacing.halfHorizontal)
  }
}

#Preview {
  TUIToggleRow(contentView: {
    TUITextRow("TUIToggleRow", style: .textDescription("This is a TUIToggleRow"))
  }, toggle: {
    TUIToggleSwitch(isSelected: true) {
      
    }
  })
}
