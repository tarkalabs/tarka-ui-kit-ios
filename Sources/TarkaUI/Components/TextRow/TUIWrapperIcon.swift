//
//  TUIWrapperIcon.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

public struct TUIWrapperIcon: View {
  
  public var action: () -> Void
  public var icon: FluentIcon
  public var color: Color = .disabledContent
  public var disableInteraction = false

  public init(icon: FluentIcon,
              action: @escaping () -> Void) {
    self.icon = icon
    self.action = action
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      Image(fluent: icon)
        .scaledToFit()
        .frame(width: 20, height: 20)
        .padding(.horizontal, Spacing.custom(2.0))
        .clipped()
        .foregroundColor(color)
    }
    .frame(width: 24, height: 40)
    .disabled(disableInteraction)
    .accessibilityIdentifier(Accessibility.wrapperIcon)
  }
}

struct TUIWrapperIcon_Previews: PreviewProvider {
  
  static var previews: some View {
    TUIWrapperIcon(icon: .errorCircle24Filled) { }
      .iconColor(.red)
  }
}

extension TUIWrapperIcon {
  enum Accessibility: String, TUIAccessibility {
    case wrapperIcon = "Wrapper Icon"
  }
}
