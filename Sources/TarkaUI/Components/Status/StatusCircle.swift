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
  
  private var status: ActiveStatus
  
  public init(_ status: ActiveStatus) {
    self.status = status
  }
  public var body: some View {
    
    let circleSize = Spacing.halfHorizontal
    Circle()
      .fill(status.color)
      .frame(width: circleSize, height: circleSize)
      .padding(.all, 6.0)
  }
}

struct StatusCircle_Previews: PreviewProvider {
  static var previews: some View {
    StatusCircle(.on)
  }
}
