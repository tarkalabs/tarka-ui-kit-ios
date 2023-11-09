//
//  TUIStatusCircle.swift
//  
//
//  Created by Gopinath on 29/05/23.
//

import SwiftUI

public struct TUIStatusCircle: View {
  
  public var color: Color
  
  public var body: some View {
    
    let circleSize = Spacing.halfHorizontal
    Circle()
      .fill(color)
      .frame(width: circleSize, height: circleSize)
      .padding(.all, 6.0)
      .accessibilityIdentifier(Accessibility.status)
  }
}

extension TUIStatusCircle {
  enum Accessibility: String, TUIAccessibility {
    case status = "Status"
  }
}

struct TUIStatusCircle_Previews: PreviewProvider {
  static var previews: some View {
    TUIStatusCircle(color: Color.success)
  }
}
