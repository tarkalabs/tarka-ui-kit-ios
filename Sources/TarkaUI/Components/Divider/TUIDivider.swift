//
//  TUIDivider.swift
//  
//
//  Created by Gopinath on 18/07/23.
//

import SwiftUI

public struct TUIDivider: View {
  
  var color = Color.surfaceHover
  private var orientation: Orientation

  public init(orientation: Orientation) {
    self.orientation = orientation
  }
  
  public var body: some View {
    
    Rectangle()
      .frame(width: width, height: height)
      .foregroundColor(.clear)
      .background(color)
      .padding(.horizontal, orientation.hPadding)
      .padding(.vertical, orientation.vPadding)
  }
}

extension TUIDivider {

  var width: CGFloat {
    
    if case .horizontal = self.orientation  {
      return .infinity
    }
    return 1
  }
  
  var height: CGFloat {
    
    if case .horizontal = self.orientation  {
      return 1
    }
    return 40
  }
}

struct TUIDivider_Previews: PreviewProvider {
  
  static var previews: some View {
    
    VStack (spacing: 16) {
      
      ForEach(TUIDivider.VerticalPadding.allCases) { vPadding in
        
        ForEach(TUIDivider.HorizontalPadding.allCases) { hPadding in
          
          TUIDivider(
            orientation: .horizontal(
              hPadding: hPadding, vPadding: vPadding))
            .color(.black)
        }
      }
      
      VStack(alignment: .leading, spacing: 16) {
        
        ForEach(TUIDivider.VerticalPadding.allCases) { hPadding in
          
          TUIDivider(
            orientation: .vertical(hPadding: hPadding))
            .color(.black)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.all, 16)
  }
}
