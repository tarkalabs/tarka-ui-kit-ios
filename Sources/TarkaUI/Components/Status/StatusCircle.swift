//
//  StatusCircle.swift
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
  
  public var text: String {
    switch self {
    case .on: return "Connected"
    case .off: return "Disconnected"
    }
  }
}

public struct StatusCircle: View {
  
  @State private var status: ActiveStatus
  
  public init(_ status: ActiveStatus) {
    self.status = status
  }
  public var body: some View {
    
    ZStack {
      let viewSize = Spacing.custom(20)
      Rectangle()
        .fill(.background)
        .frame(width: viewSize, height: viewSize)
      
      let circleSize = Spacing.halfHorizontal
      Circle()
        .fill(status.color)
        .frame(width: circleSize, height: circleSize)
    }
  }
}

struct StatusCircle_Previews: PreviewProvider {
    static var previews: some View {
      StatusCircle(.on)
    }
}
