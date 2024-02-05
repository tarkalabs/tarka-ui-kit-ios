//
//  TUIRadioButton.swift
//
//
//  Created by MAHESHWARAN on 02/02/24.
//

import SwiftUI

public struct TUIRadioButton: View {
  
  private var inputItem: InputItem
  
  public init() {
    self.inputItem = .init()
  }
  
  public var body: some View {
    Circle()
      .stroke(inputItem.color, lineWidth: 1.5)
      .frame(width: 24, height: 24)
      .overlay(content: backgroundColor)
      .accessibilityElement(children: .contain)
      .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  func backgroundColor() -> some View {
    switch inputItem.state {
    case .normal:
      
      switch inputItem.style {
      case .selected:
        Color.primaryTUI
          .frame(width: 22, height: 22)
          .overlay {
            Color.surface
              .frame(width: 8, height: 8)
              .clipShape(Circle())
          }
          .clipShape(Circle())
        
      case .unSelected:
        Color.surface
          .frame(width: 22, height: 22)
          .clipShape(Circle())
      }
    case .disabled:
      
      switch inputItem.style {
      case .selected:
        Color.disabledContent.opacity(0.06)
          .frame(width: 22, height: 22)
          .overlay {
            Color.disabledBackground.opacity(0.38)
              .frame(width: 8, height: 8)
              .clipShape(Circle())
          }
          .clipShape(Circle())
        
      case .unSelected:
        Color.surface
          .frame(width: 22, height: 22)
          .clipShape(Circle())
      }
    }
  }
}

// MARK: - InputItem

extension TUIRadioButton {
  
  struct InputItem {
    var style = Style.unSelected
    var state = State.normal
    
    var color: Color {
      switch state {
      case .normal:
        switch style {
        case .selected: return .clear
        case .unSelected: return .outline
        }
        
      case .disabled:
        switch style {
        case .selected: return .clear
        case .unSelected: return .disabledContent.opacity(0.38)
        }
      }
    }
  }
}

// MARK: - Style

public extension TUIRadioButton {
  
  enum Style {
    case selected, unSelected
  }
  
  enum State {
    case normal, disabled
  }
}

// MARK: - Modifiers

public extension TUIRadioButton {
  
  func style(_ style: Style) -> Self {
    var newView = self
    newView.inputItem.style = style
    return newView
  }
  
  func state(_ style: State) -> Self {
    var newView = self
    newView.inputItem.state = style
    return newView
  }
}

public extension TUIRadioButton {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIRadioButton"
  }
}

// MARK: - Preview

struct TUIRadioButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 20) {
      TUIRadioButton()
      
      TUIRadioButton()
        .style(.selected)
      
      TUIRadioButton()
        .state(.disabled)
      
      TUIRadioButton()
        .state(.disabled)
        .style(.selected)
    }
  }
}
