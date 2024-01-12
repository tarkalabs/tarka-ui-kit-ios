//
//  TUIToggleSwitch.swift
//
//
//  Created by MAHESHWARAN on 12/01/24.
//

import SwiftUI

/// `TUIToggleSwitch` is a  container view that displays toggle Switch.
///
/// Example usage:
///
///     TUIToggleSwitch(false) { }
///       .style(.disabled)
///
/// - Parameters:
///   - isSelected: This Bool is used to toggle between on and off selection,
///   - action: This will tigger when button action
///
/// - Returns: A closure that returns the content

public struct TUIToggleSwitch: View {
  
  private var style: Style = .normal
  private let isSelected: Bool
  private let action: () -> Void
  
  public init(_ isSelected: Bool, action: @escaping () -> Void) {
    self.isSelected = isSelected
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      Image(icon: style.icon(isSelected))
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
}

// MARK: - Style

public extension TUIToggleSwitch {
  
  enum Style {
    case normal, disabled
    
    func icon(_ isSelected: Bool) -> Icon {
      switch self {
      case .normal:
        return isSelected ? .toggleSwitchOn : .toggleSwitchOff
      case .disabled:
        return isSelected ? .toggleSwitchDisabledOn : .toggleSwitchDisabledOff
      }
    }
  }
}

// MARK: - Modifiers

public extension TUIToggleSwitch {
  
  func style(_ style: Style) -> Self {
    var newView = self
    newView.style = style
    return newView
  }
}

// MARK: - Accessibility

public extension TUIToggleSwitch {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIToggleSwitch"
  }
}
