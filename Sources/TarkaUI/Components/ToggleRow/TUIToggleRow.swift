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
public struct TUIToggleRow<Content: View>: View {
  public var contentView: () -> Content
  public var toggle: () -> TUIToggleSwitch
  
  public init(
    @ViewBuilder contentView: @escaping () -> Content,
    @ViewBuilder toggle: @escaping () -> TUIToggleSwitch
  ) {
    self.contentView = contentView
    self.toggle = toggle
  }
  
  public var body: some View {
    HStack(spacing: Spacing.baseHorizontal) {
      contentView()
      Spacer()
      toggle()
    }
    .padding(.vertical, Spacing.custom(11))
    .padding(.horizontal, Spacing.halfHorizontal)
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIToggleRow {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIToggleRow"
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
