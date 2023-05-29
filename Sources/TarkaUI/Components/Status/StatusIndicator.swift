//
//  StatusIndicator.swift
//  
//
//  Created by Gopinath on 29/05/23.
//

import SwiftUI

public struct StatusIndicator: View {
  
  @State private var status: ActiveStatus
  
  public init(_ status: ActiveStatus) {
    self.status = status
  }
  public var body: some View {
    HStack(spacing: Spacing.halfHorizontal) {
      Text(status.text)
        .font(.button8)
        .foregroundColor(.disabledContent)
      
      StatusCircle(.on)
    }
  }
}

struct StatusIndicator_Previews: PreviewProvider {
  static var previews: some View {
    StatusIndicator(.on)
  }
}
