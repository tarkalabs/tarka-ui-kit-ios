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
  var iconColor: Color = .disabledContent

  public init(image: Icon,
              action: @escaping () -> Void) {
    self.image = image
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
        .foregroundColor(iconColor)
        .padding(.horizontal, Spacing.custom(2.0))
    }
    .frame(height: 40)
    .accessibilityIdentifier(Accessibility.wrapperIcon)
  }
}

public extension TUIWrapperIcon {
  
  func iconColor(_ color: Color) -> TUIWrapperIcon {
    var newView = self
    newView.iconColor = color
    return newView
  }
}

struct TUIWrapperIcon_Previews: PreviewProvider {
  
  static var previews: some View {
    TUIWrapperIcon(image: Symbol.info) { }
      .iconColor(.black)
  }
}

extension TUIWrapperIcon {
  enum Accessibility: String, TUIAccessibility {
    case wrapperIcon = "Wrapper Icon"
  }
}
