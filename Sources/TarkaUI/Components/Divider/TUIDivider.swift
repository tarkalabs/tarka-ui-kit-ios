//
//  TUIDivider.swift
//  
//
//  Created by Gopinath on 18/07/23.
//

import SwiftUI

public struct TUIDivider: View {
  
  public var orientation = Orientation.horizontal
  
  public var tbPadding: CGFloat = 0
  public var lrPadding: CGFloat = 0
  public var color = Color.surfaceHover
  
  public init() { }
  
  public var body: some View {
    
    Rectangle()
      .setHeight(for: orientation)
      .foregroundColor(.clear)
      .background(color)
      .padding(.horizontal, lrPadding)
      .padding(.vertical, tbPadding)
  }
}

private extension View {
  
  @ViewBuilder
  func setHeight(for orientation: TUIDivider.Orientation) -> some View {
    
    if orientation == .horizontal {
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
      
      ForEach(TUIDivider.TBPadding.allCases) { tbPadding in
        
        ForEach(TUIDivider.LRPadding.allCases) { lrPadding in
          
          TUIDivider()
            .horizontal(lrPadding: lrPadding, tbPadding: tbPadding)
            .color(.black)
        }
      }
      
      VStack(alignment: .leading, spacing: 16) {
        
        ForEach(TUIDivider.TBPadding.allCases) { lrPadding in
          
          TUIDivider()
            .vertical(lrPadding: lrPadding)
            .color(.black)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.all, 16)
  }
}
