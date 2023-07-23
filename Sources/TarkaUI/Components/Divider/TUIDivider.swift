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
      .setHeight(for: orientation)
      .foregroundColor(.clear)
      .background(color)
      .padding(.horizontal, orientation.hPadding)
      .padding(.vertical, orientation.vPadding)
  }
}

private extension View {
  
  @ViewBuilder
  func setHeight(for orientation: TUIDivider.Orientation) -> some View {
    
    if case .horizontal = orientation  {
      self
        .frame(maxWidth: .infinity)
        .frame(height: 1)
    } else {
      self
        .frame(height: 40)
        .frame(width: 1)
    }
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
