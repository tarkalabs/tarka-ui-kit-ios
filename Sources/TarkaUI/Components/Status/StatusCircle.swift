//
//  StatusCircle.swift
//  
//
//  Created by Gopinath on 29/05/23.
//

import SwiftUI

public struct StatusCircle: View {
  
  public var color: Color
  
  public var body: some View {
    
    let circleSize = Spacing.halfHorizontal
    Circle()
      .fill(color)
      .frame(width: circleSize, height: circleSize)
      .padding(.all, 6.0)
  }
}

struct StatusCircle_Previews: PreviewProvider {
  static var previews: some View {
    StatusCircle(color: Color.success)
  }
}
