//
//  SwiftUIView.swift
//
//
//  Created by Arvindh Sukumar on 14/08/23.
//

import SwiftUI
import JustifiableFlowLayout

public struct TUIEmailField: View {
  public var emails: [String] = []
  public var addAction: () -> Void
  public var removeAction: (String) -> Void
  
  public var body: some View {
    VStack(spacing: Spacing.baseVertical) {
      HStack(alignment: .top, spacing: Spacing.halfHorizontal) {
        label
        emailField
        addButton
      }
      .padding(.leading, 24)
      .padding(.trailing, 8)
      
      TUIDivider(
        orientation: .horizontal(hPadding: .zero, vPadding: .zero)
      )
    }
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
    JustifiableFlowLayout(minSpacing: Spacing.halfHorizontal) {
      ForEach(emails, id: \.self) { email in
        TUIChipView(email)
          .style(
            .input(
              .titleWithButton(
                .dismiss16Filled,
                action: {
                  removeAction(email)
                }
              )
            ),
            size: .size32
          )
          .backgroundColor(.surfaceVariant)
          .borderColor(.surfaceVariant)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.top, Spacing.baseVertical)
  }
  
  @ViewBuilder
  private var addButton: some View {
    TUIIconButton(
      icon: .addCircle24Regular,
      action: addAction
    )
    .size(.size48)
  }
}

struct TUIEmailField_Previews: PreviewProvider {
  static let emails = [
    "arvindh@tarkalabs.com",
    "john@eam360.com",
    "michael@sedintechnologies.com"
  ]
  
  static var previews: some View {
    TUIEmailField(emails: emails) {
      
    } removeAction: { email in
      
    }
  }
}
