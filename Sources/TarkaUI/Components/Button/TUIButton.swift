//
//  TUIButton.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public struct TUIButton: View {
  
  enum Style {
    case primary, secondary, outlined, ghost, danger
    
    var backgroundColor: Color {
      switch self {
        
      case .primary:
        return .primaryTUI
      case .secondary:
        return .secondaryTUI
      case .outlined:
        return .onSurface
      case .ghost:
        return .clear
      case .danger:
        return .error
      }
    }
    
    var textColor: Color {
      switch self {
        
      case .primary:
        return .onPrimary
      case .secondary:
        return .onSecondary
      case .outlined:
        return .onSurface
      case .ghost:
        return .secondary
      case .danger:
        return .onPrimary
      }
    }
  }
  
  
  enum Icon {
    case left(FluentIcon), right(FluentIcon)
  }
  
  var title: String
  var style: Style = .primary
  var size: Size = .regular
  var icon: Icon?
  var badge: String?
  var action: () -> Void
  
  public init(title: String,
              action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      Text(title)
        .font(.button6)
        .foregroundColor(.onPrimary)
        .padding(.vertical, Spacing.custom(18))
        .frame(maxWidth: .infinity)
    }
    .contentShape(Rectangle())
    .tint(.primaryTUI)
    .buttonStyle(.borderedProminent)
    .buttonBorderShape(.capsule)
  }
}

struct TUIButton_Previews: PreviewProvider {
  static var previews: some View {
    TUIButton(title: "Save") { }
  }
}

extension TUIButton {
  
  enum Size {
    
    case xs, small, regular, large
    
    func leading(for icon: Icon?) -> CGFloat {
      
      guard let icon else {
        // no icon
        return leadingWithoutIcon
      }
      
      switch icon {
        
      case .right:
        return paddingWithTitle
        
      case .left:
        return paddingWithIcon
      }
    }
    
    func trailing(for icon: Icon?) -> CGFloat {
      
      guard let icon else {
        // no icon
        return leadingWithoutIcon
      }
      
      switch icon {
        
      case .right:
        return paddingWithIcon
        
      case .left:
        return paddingWithTitle
      }
    }
    
    var leadingWithoutIcon: CGFloat {
      switch self {
      case .large:
        return 24
      case .regular:
        return 24
      case .small:
        return 16
      case .xs:
        return 8
      }
    }
    var paddingWithTitle: CGFloat {
      switch self {
      case .large:
        return 24
      case .regular:
        return 24
      case .small:
        return 16
      case .xs:
        return 8
      }
    }
    
    var paddingWithIcon: CGFloat {
      switch self {
      case .large:
        return 16
      case .regular:
        return 16
      case .small:
        return 8
      case .xs:
        return 4
      }
    }
  }
}
