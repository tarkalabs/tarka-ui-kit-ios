//
//  TUIEmailSubjectField.swift
//
//
//  Created by Arvindh Sukumar on 15/08/23.
//

import SwiftUI

public struct TUIEmailSubjectField: View {
  @Binding public var text: String

  private var title: String

  public init(text: Binding<String>, title: String = "Subject") {
    self._text = text
    self.title = title.localized
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      TextField(
        "",
        text: $text,
        prompt: Text(title)
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
    .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIEmailSubjectField {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIEmailSubjectField"
  }
}

struct TUIEmailSubjectField_Previews: PreviewProvider {
  static var previews: some View {
    TUIEmailSubjectField(text: .constant("Subject"), title: "Subject")
  }
}
