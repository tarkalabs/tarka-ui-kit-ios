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
  public var color: Color

  public init(image: Icon, color: Color? = nil,
              action: @escaping () -> Void) {
    self.image = image
    self.color = color ?? .disabledContent
    self.action = action
  }
  
  public static func info(action: @escaping () -> Void) -> TUIWrapperIcon {
    return self.init(image: Symbol.info, action: action)
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
