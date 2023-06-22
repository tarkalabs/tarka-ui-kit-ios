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

  public init(image: Icon,
              action: @escaping () -> Void) {
    self.image = image
    self.action = action
  }
  
  public static func info(
    action: @escaping () -> Void) -> TUIWrapperIcon {
      
      let icon = self.init(image: Symbol.info, action: action)
      return icon
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
    TUIWrapperIcon(image: Symbol.error) { }
      .iconColor(.red)
  }
}

extension TUIWrapperIcon {
  enum Accessibility: String, TUIAccessibility {
    case wrapperIcon = "Wrapper Icon"
  }
}

extension TUIWrapperIcon {
  
  public func iconColor(_ color: Color) -> TUIWrapperIcon {
    var newView = self
    newView.color = color
    return newView
  }
}
