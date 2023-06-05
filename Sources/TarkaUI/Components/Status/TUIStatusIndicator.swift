//
//  TUIStatusIndicator.swift
//  
//
//  Created by Gopinath on 29/05/23.
//

import SwiftUI

public enum TUIActiveStatus {
  case on, off
  
  public var color: Color {
    switch self {
    case .on: return Color.success
    case .off: return Color.error
    }
  }
}

public struct TUIStatusIndicator: View {
  
  private var status: TUIActiveStatus
  private var text: String?

  public init(_ status: TUIActiveStatus, text: String? = nil) {
    self.status = status
    self.text = text
  }
  public var body: some View {
    HStack(spacing: Spacing.halfHorizontal) {
      if let text, !text.isEmpty {
        Text(text)
          .font(.button8)
          .foregroundColor(.disabledContent)
          .accessibilityIdentifier(Accessibility.label)
      }
      TUIStatusCircle(color: status.color)
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIStatusIndicator {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIStatusIndicator"
    case label = "Label"
  }
}

struct TUIStatusIndicator_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TUIStatusIndicator(.on)
      TUIStatusIndicator(.off, text: "Disconnected")
    }
  }
}
