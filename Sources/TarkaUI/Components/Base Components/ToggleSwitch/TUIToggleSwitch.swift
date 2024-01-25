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
  
  private var style: Style
  
  public init(isSelected: Bool = false, _ action: @escaping () -> Void) {
    self.style = .init(isSelected: isSelected, action: action)
  }
  
  public var body: some View {
    Button(action: style.action, label: contentView)
      .accessibilityElement(children: .contain)
      .accessibilityIdentifier(Accessibility.root)
  }
  
  private func contentView() -> some View {
    Rectangle()
      .fill(style.backgroundColor)
      .frame(width: style.size.width, height: style.size.height)
      .clipShape(Capsule())
      .overlay(alignment: style.alignment, content: toggleView)
      .accessibilityElement(children: .contain)
  }
  
  private func toggleView() -> some View {
    ZStack {
      Circle()
        .fill(style.toggleBackgroundColor)
        .frame(width: style.toggleStyle.size.width,
               height: style.toggleStyle.size.height)
      
      Image(fluent: style.icon)
        .foregroundStyle(style.iconColor)
        .accessibilityIdentifier(Accessibility.icon)
    }
    .padding(style.togglePadding, TarkaUI.Spacing.custom(2))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.switchView)
  }
}

// MARK: - Style

extension TUIToggleSwitch {
  
  struct Style {
    var toggleStyle: ToggleStyle
    var isSelected: Bool
    var action: () -> Void
    
    var color = Color.surfaceVariant
    var selectionColor = Color.primaryTUI
    
    var toggleColor = Color.onSurface
    var toggleSelectionColor = Color.constantLight
    
    public init(_ style: ToggleStyle = .normal, isSelected: Bool = false, action: @escaping () -> Void) {
      self.toggleStyle = style
      self.isSelected = isSelected
      self.action = action
    }
    
    var backgroundColor: Color {
      switch toggleStyle {
      case .normal:
        return isSelected ? selectionColor : color
      case .disabled:
        return .disabledBackground
      }
    }
    
    var size: CGSize {
      .init(width: 40, height: 24)
    }
    
    var alignment: Alignment {
      isSelected ? .trailing : .leading
    }
    
    var togglePadding:  Edge.Set {
      isSelected ? .trailing : .leading
    }
    
    var icon: FluentIcon {
      isSelected ? .checkmark16Filled : .dismiss16Filled
    }
    
    var iconColor: Color {
      switch toggleStyle {
      case .normal:
        return isSelected ? selectionColor : color
      case .disabled:
        return .inputBackground
      }
    }
    
    var toggleBackgroundColor: Color {
      switch toggleStyle {
      case .normal:
        return isSelected ? toggleSelectionColor : toggleColor
      case .disabled:
        return .disabledContent
      }
    }
  }
}

// MARK: - ToggleStyle


public extension TUIToggleSwitch {
  
  enum ToggleStyle {
    case normal, disabled
    
    var size: CGSize {
      .init(width: 20, height: 20)
    }
  }
}

// MARK: - Modifiers

public extension TUIToggleSwitch {
  
  func style(_ style: ToggleStyle) -> Self {
    var newView = self
    newView.style.toggleStyle = style
    return newView
  }
  
  func backgroundColor(_ color: Color) -> Self {
    var newView = self
    newView.style.color = color
    return newView
  }
  
  func backgroundSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.style.selectionColor = color
    return newView
  }
  
  func toggleColor(_ color: Color) -> Self {
    var newView = self
    newView.style.toggleColor = color
    return newView
  }
  
  func toggleSelectionColor(_ color: Color) -> Self {
    var newView = self
    newView.style.toggleSelectionColor = color
    return newView
  }
}

// MARK: - Accessibility

public extension TUIToggleSwitch {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIToggleSwitch"
    case switchView = "SwitchView"
    case icon = "IconView"
  }
}

// MARK: - Preview

struct TUIToggleSwitch_Previews: PreviewProvider {
  
  static var previews: some View {
    ToggleSwitchPreview()
  }
  
  struct ToggleSwitchPreview: View {
    
    @State private var isSelected = false
    @State private var isSelected1 = false
    @State private var isSelected2 = false
    
    var body: some View {
      VStack {
        TUIToggleSwitch(isSelected: isSelected) {
          isSelected.toggle()
        }
        
        TUIToggleSwitch(isSelected: isSelected1) {
          isSelected1.toggle()
        }
        .style(.disabled)
        
        TUIToggleSwitch(isSelected: isSelected2) {
          isSelected2.toggle()
        }
        .backgroundColor(Color.success)
        .toggleColor(.white)
        .backgroundSelectionColor(Color.yellow)
        .toggleSelectionColor(Color.success)
      }
    }
  }
}
