//
//  TUIDetailDisclosure.swift
//
//
//  Created by Arvindh Sukumar on 18/05/23.
//

import SwiftUI

public struct TUIDetailDisclosure: View {
  
  public var body: some View {
    
    Image(fluent: .arrowRight20Filled)
      .scaledToFit()
      .frame(width: 18, height: 18)
      .padding(.all, Spacing.custom(2.0))
      .clipped()
      .foregroundColor(Color.outline)
      .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIDetailDisclosure {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIDetailDisclosure"
  }
}

struct DetailDisclosure_Previews: PreviewProvider {
  static var previews: some View {
    TUIDetailDisclosure()
  }
}
