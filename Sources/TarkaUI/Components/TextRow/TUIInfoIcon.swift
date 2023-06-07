//
//  TUIInfoIcon.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

public struct TUIInfoIcon: View {
  
  var action: () -> Void
  public var body: some View {
    Button {
      action()
    } label: {
      Image(Symbol.info)
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
        .foregroundColor(Color.disabledContent)
        .padding(.horizontal, 2.0)
    }
    .frame(height: 40)
  }
}

struct TUIInfoIcon_Previews: PreviewProvider {
  static var previews: some View {
    TUIInfoIcon() { }
  }
}
