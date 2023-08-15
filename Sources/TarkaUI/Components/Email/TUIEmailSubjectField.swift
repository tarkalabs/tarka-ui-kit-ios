//
//  TUIEmailSubjectField.swift
//
//
//  Created by Arvindh Sukumar on 15/08/23.
//

import SwiftUI

public struct TUIEmailSubjectField: View {
  @Binding public var text: String
  
  public init(text: Binding<String>) {
    self._text = text
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      TextField(
        "",
        text: $text,
        prompt: Text("Subject".localized)
          .font(.body7)
          .foregroundColor(.outline)
      )
      .font(.heading7)
      .padding(.leading, Spacing.custom(24))
      .padding(.trailing, Spacing.halfHorizontal)
      .padding(.vertical, Spacing.custom(15))
      
      TUIDivider(
        orientation: .horizontal(
          hPadding: .zero,
          vPadding: .zero
        )
      )
    }
    .frame(maxWidth: .infinity)
  }
}

struct TUIEmailSubjectField_Previews: PreviewProvider {
  static var previews: some View {
    TUIEmailSubjectField(text: .constant("Subject"))
  }
}
