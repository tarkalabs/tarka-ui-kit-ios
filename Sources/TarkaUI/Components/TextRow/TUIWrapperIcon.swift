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
  public var color: Color = .disabledContent
  public var isInteractionEnabled = true

  public init(image: Icon,
              action: @escaping () -> Void) {
    self.image = image
    self.action = action
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      Image(image)
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
        .foregroundColor(color)
        .padding(.horizontal, Spacing.custom(2.0))
    }
    .frame(height: 40)
    .allowsHitTesting(isInteractionEnabled)
    .accessibilityIdentifier(Accessibility.wrapperIcon)
  }
}

struct TUIWrapperIcon_Previews: PreviewProvider {
  
  static var previews: some View {
    TUIWrapperIcon(image: Symbol.error) { }
      .iconColor(.red)
  }
}

extension TUIWrapperIcon {
  enum Accessibility: String, TUIAccessibility {
    case wrapperIcon = "Wrapper Icon"
  }
}
