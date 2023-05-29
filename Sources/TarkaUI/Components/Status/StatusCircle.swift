//
//  StatusCircle.swift
//  
//
//  Created by Gopinath on 29/05/23.
//

import SwiftUI

struct StatusCircle: View {
  
  private var status: ActiveStatus
  
  init(_ status: ActiveStatus) {
    self.status = status
  }
  var body: some View {
    
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
