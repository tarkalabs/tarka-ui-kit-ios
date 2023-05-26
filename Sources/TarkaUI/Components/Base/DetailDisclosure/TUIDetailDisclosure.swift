//
//  TUIDetailDisclosure.swift
//
//
//  Created by Arvindh Sukumar on 18/05/23.
//

import SwiftUI

public struct TUIDetailDisclosure: View {
  public var body: some View {
    Image(Symbol.chevronRight)
      .resizable()
      .scaledToFill()
      .frame(width: 20, height: 22)
      .foregroundColor(Color.disabledContent)
  }
}

struct DetailDisclosure_Previews: PreviewProvider {
  static var previews: some View {
    TUIDetailDisclosure()
  }
}
