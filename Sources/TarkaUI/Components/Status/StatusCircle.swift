//
//  StatusCircle.swift
//  
//
//  Created by Gopinath on 29/05/23.
//

import SwiftUI

enum ActiveStatus {
  case on, off
  
  var color: Color {
    switch self {
    case .on: return Color.success
    case .off: return Color.error
    }
  }
  
  var text: String {
    switch self {
    case .on: return "Connected"
    case .off: return "Disconnected"
    }
  }
}

struct StatusCircle: View {
  
  @State private var status: ActiveStatus
  
  init(_ status: ActiveStatus) {
    self.status = status
  }
  var body: some View {
    
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
