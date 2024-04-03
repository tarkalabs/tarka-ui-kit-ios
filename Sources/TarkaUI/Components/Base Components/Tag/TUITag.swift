//
//  TUITag.swift
//
//
//  Created by MAHESHWARAN on 25/01/24.
//

import SwiftUI

/// `TUITag` is a  container view that displays title and icon
///  This view can be used in any SwiftUI view.
///
/// Example usage:
///
///      TUITag("Hello")
///        .style(.high)
///        .size(.size34)
///        .iconStyle(.left(.circle24Regular))
///
///
/// - Parameters:
///   - title: This can be any String
///
/// - Returns: A closure that returns the content
///
public struct TUITag: View {
  
  private var style: Style
  
  public init(_ title: String? = nil) {
    self.style = .init(title: title)
  }
  
  public var body: some View {
    mainView(for: style.color.foregroundColor,
             background: style.color.background)
  }
  
  @ViewBuilder
  private func mainView(for foreground: Color, background: Color) -> some View {
    HStack(spacing: style.spacing) {
      switch style.icon {
      case .none: titleView
        
      case .left(let icon):
        iconView(for: icon)
        titleView
        
      case .right(let icon):
        titleView
        iconView(for: icon)
      
      case .icon(let icon):
        iconView(for: icon)
      }
    }
    .padding(.vertical, style.verticalPadding)
    .padding(.leading, style.leadingPadding)
    .padding(.trailing, style.trailingPadding)
    .foregroundStyle(foreground)
    .frame(height: style.size.height)
    .background(background)
    .clipShape(RoundedRectangle(cornerRadius: 4))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  private var titleView: some View {
    Text(style.title ?? "")
      .font(style.size.font)
      .accessibilityIdentifier(Accessibility.title)
  }
  
  private func iconView(for icon: Image) -> some View {
    icon
      .resizable()
      .frame(width: style.iconSize.width, height: style.iconSize.height)
      .accessibilityIdentifier(Accessibility.icon)
  }
}

// MARK: - Style

extension TUITag {
  
  struct Style {
    
    var title: String?
    var tagStyle: TagStyle = .high
    var size: TagSize = .size24
    var icon: IconStyle = .none
    
    var verticalPadding: CGFloat {
      icon.spacing(size)
    }
    
    var leadingPadding: CGFloat {
      icon.leadingPadding(size)
    }
    
    var trailingPadding: CGFloat {
      icon.trailingPadding(size)
    }
    
    var spacing: CGFloat {
      icon.spacing(size)
    }
    
    var iconSize: CGSize {
      icon.iconSize(size)
    }
    
    var color: (foregroundColor: Color, background: Color) {
      switch tagStyle {
      case .high(let foregroundColor, let background):
        return (foregroundColor, background)
      case .low(let foregroundColor, let background):
        return (foregroundColor, background)
      }
    }
  }
}

public extension TUITag {
  
  enum TagStyle {
    case low(foregroundColor: Color, background: Color),
         high(foregroundColor: Color, background: Color)
    
    static public let high = TagStyle.high(foregroundColor: .onSecondary, background: .secondaryTUI)
    static public let low = TagStyle.high(foregroundColor: .onSecondaryAlt, background: .secondaryAlt)
  }
  
  enum TagSize {
    case size24, size34, size40
    
    var height: CGFloat {
      switch self {
      case .size24: return 24
      case .size34: return 34
      case .size40: return 40
      }
    }
    
    var font: Font {
      switch self {
      case .size24: return .button8
      case .size34: return .button7
      case .size40: return .button6
      }
    }
  }
  
  enum IconStyle {
    case none, left(Image), right(Image), icon(Image)
    
    func iconSize(_ tagSize: TagSize) -> CGSize {
      switch tagSize {
      case .size24: return .init(width: 16, height: 16)
      case .size34, .size40: return .init(width: 20, height: 20)
      }
    }
    
    func spacing(_ size: TagSize) -> CGFloat {
      switch size {
      case .size24:
        switch self {
        case .none, .icon: return 0
        case .left, .right: return 4
        }
      case .size34:
        switch self {
        case .none, .icon: return 0
        case .left, .right: return 6
        }
      case .size40:
        switch self {
        case .none, .icon: return 0
        case .left, .right: return 8
        }
      }
    }
    
    func verticalPadding(_ size: TagSize) -> CGFloat {
      switch size {
      case .size24: return 3
      case .size34: return 6
      case .size40: return 9
      }
    }
    
    func leadingPadding(_ size: TagSize) -> CGFloat {
      switch size {
      case .size24:
        switch self {
        case .none: return 8
        case .left, .icon: return 4
        case .right: return 10
        }
        
      case .size34:
        switch self {
        case .none: return 12
        case .left, .icon: return 6
        case .right: return 12
        }
        
      case .size40:
        switch self {
        case .none: return 16
        case .left, .icon: return 10
        case .right: return 16
        }
      }
    }
    
    func trailingPadding(_ size: TagSize) -> CGFloat {
      switch size {
      case .size24:
        switch self {
        case .none: return 8
        case .left: return 10
        case .right, .icon: return 4
        }
        
      case .size34:
        switch self {
        case .none, .left: return 12
        case .right, .icon: return 6
        }
        
      case .size40:
        switch self {
        case .none, .left: return 16
        case .right, .icon: return 10
        }
      }
    }
  }
}

// MARK: - Modifiers

public extension TUITag {
  
  func style(_ style: TagStyle) -> Self {
    var newView = self
    newView.style.tagStyle = style
    return newView
  }
  
  func size(_ size: TagSize) -> Self {
    var newView = self
    newView.style.size = size
    return newView
  }
  
  func iconStyle(_ style: IconStyle) -> Self {
    var newView = self
    newView.style.icon = style
    return newView
  }
}

// MARK: - Accessibility

public extension TUITag {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUITag"
    case title = "TagTitle"
    case icon = "TagIcon"
  }
}

// MARK: - Preview

struct TUITag_Previews: PreviewProvider {
  
  static var previews: some View {
    VStack {
      TUITag("TUITag")
        .size(.size34)
        .style(.high)
      
      TUITag("TUITag")
        .size(.size34)
        .style(.high)
        .iconStyle(.left(Image(fluent: .circle24Regular)))
      
      TUITag("TUITag")
        .size(.size40)
        .style(.high)
        .iconStyle(.left(Image(fluent: .circle24Regular)))
      
      TUITag("TUITag")
        .size(.size40)
        .style(.low)
        .iconStyle(.right(Image(fluent: .circle24Regular)))
      
      TUITag("TUITag")
        .size(.size34)
        .style(.low)
        .iconStyle(.right(Image(fluent: .circle24Regular)))
      
      TUITag("TUITag")
        .size(.size34)
        .style(.low)
      
      TUITag()
        .iconStyle(.icon(Image(fluent: .circle24Regular)))
      
      TUITag()
        .style(.low)
        .iconStyle(.icon(Image(fluent: .circle24Regular)))
    }
  }
}
