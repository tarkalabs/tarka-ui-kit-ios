//
//  SwiftUIView.swift
//
//
//  Created by Arvindh Sukumar on 14/08/23.
//

import SwiftUI
import JustifiableFlowLayout

public enum TUIEmailFieldLabel {
  case to, cc, bcc
  case custom(String)
  
  var title: String {
    switch self {
    case .to: return "To".localized
    case .cc: return "Cc".localized
    case .bcc: return "Bcc".localized
    case .custom(let title): return title
    }
  }
}
public struct TUIEmailField: View {
  public var label: TUIEmailFieldLabel = .to
  public var emails: [String] = []
  public var addAction: () -> Void
  public var removeAction: (String) -> Void
  
  public init(
    label: TUIEmailFieldLabel,
    emails: [String],
    addAction: @escaping () -> Void,
    removeAction: @escaping (String) -> Void
  ) {
    self.label = label
    self.emails = emails
    self.addAction = addAction
    self.removeAction = removeAction
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      HStack(alignment: .top, spacing: Spacing.halfHorizontal) {
        labelView
        emailField
        addButton
      }
      
      TUIDivider(
        orientation: .horizontal(hPadding: .zero, vPadding: .zero)
      )
    }
  }
  
  @ViewBuilder
  private var labelView: some View {
    Text(label.title)
      .font(.body7)
      .foregroundColor(.outline)
      .padding(.top, 15)
      .padding(.leading, 24)
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
    .padding(.vertical, emails.isEmpty ? 0 : Spacing.baseVertical)
  }
  
  @ViewBuilder
  private var addButton: some View {
    TUIIconButton(
      icon: .addCircle24Regular,
      action: addAction
    )
    .size(.size48)
    .padding(.trailing, 8)
  }
}

struct TUIEmailField_Previews: PreviewProvider {
  static let emails = [
    "arvindh@tarkalabs.com",
    "john@eam360.com",
    "michael@sedintechnologies.com"
  ]
  
  static var previews: some View {
    TUIEmailField(
      label: .to,
      emails: emails) {
      
    } removeAction: { email in
      
    }
  }
}
