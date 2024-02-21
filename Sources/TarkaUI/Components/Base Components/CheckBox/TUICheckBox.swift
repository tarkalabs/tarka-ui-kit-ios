//
//  TUICheckBox.swift
//
//
//  Created by Arvindh Sukumar on 21/02/24.
//

import SwiftUI

struct TUICheckBox: View {
  var isSelected: Bool = false
  
  var body: some View {
    Image(icon: isSelected ? .checkBoxChecked : .checkBoxUnChecked)
      .scaledToFit()
      .frame(width: 24, height: 24)
      .clipped()
  }
}

#Preview {
  Group {
    TUICheckBox(isSelected: true)
    TUICheckBox(isSelected: false)
  }
}
