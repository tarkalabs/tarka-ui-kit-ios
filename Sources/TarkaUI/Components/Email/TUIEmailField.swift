//
//  TUIEmailField.swift
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
  
  @State private var emailGridWidth: CGFloat = 0.0
  
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
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var labelView: some View {
    Text(label.title)
      .font(.body7)
      .foregroundColor(.outline)
      .padding(.top, 15)
      .padding(.leading, 24)
      .accessibilityIdentifier(Accessibility.label)
  }
  
  @ViewBuilder
  private var emailField: some View {
    // `JustifiableFlowLayout` is used here, so that the items can flow in one direction in a grid
    // with equal spacing and height, and wrap to the next line when needed
    JustifiableFlowLayout(minSpacing: Spacing.halfHorizontal) {
      ForEach(emails, id: \.self) { email in
        TUIChip(email)
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
          .frame(maxWidth: emailGridWidth)
          .accessibilityElement(children: .contain)
          .accessibilityIdentifier(Accessibility.chip)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.vertical, emails.isEmpty ? 0 : Spacing.baseVertical)
    .background {
      // Calculate and set the width of the view in a preference key
      GeometryReader { gp in
        Color.clear
          .preference(key: FloatPreferenceKey.self, value: gp.size.width)
      }
    }
    .onPreferenceChange(FloatPreferenceKey.self) { value in
      // Use the preference key to set the width as state
      emailGridWidth = value
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.chipView)
  }
  
  @ViewBuilder
  private var addButton: some View {
    TUIIconButton(
      icon: .addCircle24Regular,
      action: addAction
    )
    .size(.size48)
    .padding(.trailing, 8)
    .accessibilityIdentifier(Accessibility.addButton)
  }
}

extension TUIEmailField {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIEmailField"
    case label = "Label"
    case addButton = "AddButton"
    case chipView = "ChipView"
    case chip = "Chip"
  }
}

struct TUIEmailField_Previews: PreviewProvider {
  static let emails = [
    "arvindh@tarkalabs.com",
    "john@eam360.com",
    "michael@sedintechnologies.com"
  ]
  
  static var previews: some View {
    VStack(spacing: 0) {
      TUIEmailField(
        label: .to,
        emails: []) {
        
      } removeAction: { email in
        
      }
      
      TUIEmailField(
        label: .to,
        emails: emails) {
        
      } removeAction: { email in
        
      }
    }
  }
}
