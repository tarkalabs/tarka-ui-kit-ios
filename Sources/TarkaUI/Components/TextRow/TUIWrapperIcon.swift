//
//  TUIWrapperIcon.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

public struct TUIWrapperIcon: View {
  
  public var action: () -> Void
  public var image: Icon

  public init(image: Icon, action: @escaping () -> Void) {
    self.action = action
    self.image = image
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      Image(image)
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
        .foregroundColor(Color.disabledContent)
        .padding(.horizontal, Spacing.custom(2.0))
    }
    .frame(height: 40)
    .accessibilityIdentifier(Accessibility.wrapperIcon)
  }
}

struct TUIWrapperIcon_Previews: PreviewProvider {
  
  static var previews: some View {
    TUIWrapperIcon(image: Symbol.info) { }
  }
}

extension TUIWrapperIcon {
  enum Accessibility: String, TUIAccessibility {
    case wrapperIcon = "Wrapper Icon"
  }
}
