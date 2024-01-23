//
//  TUIFloatingActionButton.swift
//
//
//  Created by MAHESHWARAN on 23/01/24.
//

import SwiftUI

public struct TUIFloatingActionButton: View {
  
  private var style: Style
  
  public init(size: Size = .regular, _ action: @escaping () -> Void) {
    self.style = .init(size: size, action: action)
  }
  
  public var body: some View {
    Button(action: style.action, label: imageView)
      .buttonStyle(FloatingButtonStyle(for: style))
      .accessibilityIdentifier(Accessibility.root)
  }
  
  private func imageView() -> some View {
    Image(fluent: style.size.icon)
      .scaledToFit()
      .frame(width: style.iconWidth, height: style.iconHeight)
      .foregroundStyle(style.iconColor)
  }
}

// MARK: - FloatingButtonStyle

extension TUIFloatingActionButton {
  
  struct FloatingButtonStyle: ButtonStyle {
    
    private let style: Style
    
    init(for style: Style) {
      self.style = style
    }
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .frame(width: style.buttonWidth, height: style.buttonHeight)
        .background(style.backgroundColor)
        .clipShape(Circle())
        .isEnabled(configuration.isPressed) {
          $0.overlay(content: borderView)
        }
    }
    
    func borderView() -> some View {
      Circle()
        .stroke(style.borderColor, lineWidth: 1.5)
    }
  }
}

// MARK: - Style

extension TUIFloatingActionButton {
  
  struct Style {
    var size: Size
    var iconColor = Color.onPrimary
    var backgroundColor = Color.primaryTUI
    var borderColor = Color.onSurface
    var action: () -> Void
    
    var iconWidth: CGFloat {
      size.iconSize.width
    }
    
    var iconHeight: CGFloat {
      size.iconSize.height
    }
    
    var buttonWidth: CGFloat {
      size.buttonSize.width
    }
    
    var buttonHeight: CGFloat {
      size.buttonSize.height
    }
  }
}

// MARK: - Size

public extension TUIFloatingActionButton {
  
  enum Size {
    case small, regular, large
    
    var icon: FluentIcon {
      switch self {
      case .small, .regular: return .add24Regular
      case .large: return .add28Regular
      }
    }
    
    var buttonSize: CGSize {
      switch self {
      case .small: return .init(width: 40, height: 40)
      case .regular: return .init(width: 56, height: 56)
      case .large: return .init(width: 96, height: 96)
      }
    }
    
    var iconSize: CGSize {
      switch self {
      case .small, .regular: return .init(width: 24, height: 24)
      case .large: return .init(width: 28, height: 28)
      }
    }
  }
}

// MARK: - Modifiers

public extension TUIFloatingActionButton {
  
  func iconColor(_ color: Color) -> Self {
    var newView = self
    newView.style.iconColor = color
    return newView
  }
  
  func backgroundColor(_ color: Color) -> Self {
    var newView = self
    newView.style.backgroundColor = color
    return newView
  }
  
  func borderColor(_ color: Color) -> Self {
    var newView = self
    newView.style.borderColor = color
    return newView
  }
}

// MARK: - Accessibility

extension TUIFloatingActionButton {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIFloatingActionButton"
  }
}

// MARK: - Preview

struct TUIFloatingActionButton_Previews: PreviewProvider {
  
  static var previews: some View {
    VStack {
      TUIFloatingActionButton(size: .small) {}
      TUIFloatingActionButton {}
      TUIFloatingActionButton(size: .large) {}
    }
  }
}
