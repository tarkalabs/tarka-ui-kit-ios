//
//  StatusIndicator.swift
//  
//
//  Created by Gopinath on 29/05/23.
//

import SwiftUI

public enum ActiveStatus {
  case on, off
  
  public var color: Color {
    switch self {
    case .on: return Color.success
    case .off: return Color.error
    }
  }
}

public struct StatusIndicator: View {
  
  private var status: ActiveStatus
  private var text: String?

  public init(_ status: ActiveStatus, text: String? = nil) {
    self.status = status
    self.text = text
  }
  public var body: some View {
    HStack(spacing: Spacing.halfHorizontal) {
      if let text, !text.isEmpty {
        Text(text)
          .font(.button8)
          .foregroundColor(.disabledContent)
      }
      StatusCircle(status)
    }
  }
}

struct StatusIndicator_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      StatusIndicator(.on)
      StatusIndicator(.off, text: "Disconnected")
    }
  }
}
