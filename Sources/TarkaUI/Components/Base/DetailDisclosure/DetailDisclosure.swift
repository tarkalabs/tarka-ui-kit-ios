//
//  DetailDisclosure.swift
//
//
//  Created by Arvindh Sukumar on 18/05/23.
//

import SwiftUI

public struct DetailDisclosure: View {
  public var body: some View {
    Image(Symbol.chevronRight)
      .resizable()
      .scaledToFit()
      .frame(width: 18, height: 18)
      .foregroundColor(Color.outline)
      .padding(.all, 2.0)
  }
}

struct DetailDisclosure_Previews: PreviewProvider {
  static var previews: some View {
    DetailDisclosure()
  }
}
