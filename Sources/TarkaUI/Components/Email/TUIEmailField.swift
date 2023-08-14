//
//  SwiftUIView.swift
//
//
//  Created by Arvindh Sukumar on 14/08/23.
//

import SwiftUI

struct TUIEmailField: View {
  var emails: [String] = []
  var addAction: () -> Void
  
  var body: some View {
    HStack(alignment: .top, spacing: Spacing.halfHorizontal) {
      label
      emailField
      addButton
    }
    .padding(.leading, 24)
    .padding(.trailing, 8)
  }
  
  @ViewBuilder
  private var label: some View {
    Text("To".localized)
      .font(.body7)
      .foregroundColor(.outline)
      .padding(.top, 15)
  }
  
  @ViewBuilder
  private var emailField: some View {
    Spacer()
  }
  
  @ViewBuilder
  private var addButton: some View {
    TUIIconButton(
      icon: .addCircle24Regular,
      action: addAction
    )
    .padding(12)
  }
}

struct TUIEmailField_Previews: PreviewProvider {
  static var previews: some View {
    TUIEmailField(emails: ["a@b.com"]) {
      
    }
  }
}
