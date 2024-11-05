//
//  TUIWrapperIcon.swift
//  
//
//  Created by Gopinath on 05/06/23.
//

import SwiftUI

public struct TUIWrapperIcon: View {
  
  var action: (() -> Void)?
  var icon: FluentIcon
  var color: Color = .disabledContent
  var disableInteraction = true

  public init(icon: FluentIcon) {
    self.icon = icon
  }
  
  public var body: some View {
    iconView
    .frame(width: 24, height: 40)
    .contentShape(.rect)
    .onTapGesture {
      action?()
    }
    .disabled(disableInteraction)
    .accessibilityIdentifier(Accessibility.wrapperIcon)
  }
  
  @ViewBuilder
  var iconView: some View {
    Image(fluent: icon)
      .scaledToFit()
      .frame(width: 20, height: 20)
      .padding(.horizontal, Spacing.custom(2.0))
      .clipped()
      .foregroundColor(color)
  }
}

struct TUIWrapperIcon_Previews: PreviewProvider {
  
  static var previews: some View {
    TUIWrapperIcon(icon: .errorCircle24Filled)
      .iconColor(.red)
  }
}

extension TUIWrapperIcon {
  enum Accessibility: String, TUIAccessibility {
    case wrapperIcon = "Wrapper Icon"
  }
}
