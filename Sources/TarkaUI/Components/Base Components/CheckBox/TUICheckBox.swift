//
//  TUICheckBox.swift
//
//
//  Created by Arvindh Sukumar on 21/02/24.
//

import SwiftUI

public struct TUICheckBox: View {
  var isSelected: Bool = false
  
  public init(isSelected: Bool) {
    self.isSelected = isSelected
  }
  
  public var body: some View {
    Image(icon: isSelected ? TUIIcon.checkBoxChecked : .checkBoxUnChecked)
      .scaledToFit()
      .frame(width: 24, height: 24)
      .clipped()
      .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUICheckBox {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUICheckBox"
  }
}

#Preview {
  Group {
    TUICheckBox(isSelected: true)
    TUICheckBox(isSelected: false)
  }
}
