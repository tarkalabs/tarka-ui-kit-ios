//
//  TUIBadge.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

/// A view that displays a badge with an optional count.
///
/// The badge is a pill shape with a background color of error and a text color of onError.
/// The count is displayed in the center of the badge and is optional.
///
/// Example usage:
///
///     TUIBadge(count: 10)
///       .size(.m)
///
/// - Parameters:
///   - count: The count to be displayed in the center of the badge.
///
public struct TUIBadge: View {
  /// The count to be displayed in the center of the badge.
  var badgeColor: Color?
  var size: Size
  var style: Style
  
  public init(
    style: Style = .empty,
    badgeColor: Color? = nil,
    size: Size = .size16) {
      
      self.badgeColor = badgeColor
      self.size = size
      if size == .size12 {
        self.style = .empty
      } else {
        self.style = style
      }
    }
  
  public var body: some View {
    ZStack {
      Capsule()
        .foregroundColor(badgeColor ?? .error)
        .frame(minWidth: size.width)
        .frame(height: size.height)

      if case .number(let count) = style,
         let count {
        Text("\(count)")
          .foregroundColor(.onError)
          .font(font)
          .frame(minWidth: fontSize.width)
          .frame(height: size.height)
          .padding(.horizontal, padding)
      } else if case .icon(let fluentIcon, let iconColor) = style {
        Image(fluent: fluentIcon)
          .resizable()
          .scaledToFit()
          .foregroundColor(iconColor)
          .frame(width: iconSize.width, height: iconSize.height)
          .padding(iconPadding)
          .clipped()
      } else {
        Color.clear
          .frame(width: size.width, height: size.height)
      }
    }
    .fixedSize()
  }
}

public extension TUIBadge {
  
  enum Style {
    case empty, number(Int?), icon(FluentIcon, Color)
  }
  
  enum Size {
    case size12, size16, size24
    
    private var size: CGSize {
      switch self {
      case .size12:
        return CGSize(width: 20, height: 20)
      case .size16:
        return CGSize(width: 24, height: 24) // increaseSize
      case .size24:
        return CGSize(width: 32, height: 32) // increaseSize
      }
    }
    
    var width: CGFloat {
      size.width
    }
    
    var height: CGFloat {
      size.height
    }
    
    public static var defaultValue: Size = .size24
  }
  
  private var font: Font {
    switch size {
    case .size12, .size16:
      return .button8
    case .size24:
      return .button7
    }
  }
  
  private var padding: CGFloat {
    switch size {
    case .size12:
      return 0
    case .size16:
      return 4
    case .size24:
      return 8
    }
  }
  
  private var iconSize: CGSize {
    switch size {
    case .size12:
      return CGSize(width: 0, height: 0)
    case .size16:
      return CGSize(width: 20, height: 20) // increaseSize
    case .size24:
      return CGSize(width: 24, height: 24) // increaseSize
    }
  }
  
  private var fontSize: CGSize {
    switch size {
    case .size12:
      return CGSize(width: 0, height: 0)
    case .size16:
      return CGSize(width: 8, height: 24) // increaseSize
    case .size24:
      return CGSize(width: 18, height: 32) // increaseSize
    }
  }
  
  private var iconPadding: CGFloat {
    switch size {
    case .size12:
      return 0
    case .size16:
      return 2
    case .size24:
      return 4
    }
  }
}

struct Badge_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HStack {
        TUIBadge(size: .size16)
      }
      .previewDisplayName("Plain")
      
      HStack {
        TUIBadge(style: .number(1), size: .size16)
        TUIBadge(style: .number(10), size: .size16)
        TUIBadge(style: .number(100), size: .size16)
      }
      .previewDisplayName("Count Medium")
      
      HStack {
        TUIBadge(style: .number(1), size: .size24)
        TUIBadge(style: .number(10), size: .size24)
        TUIBadge(style: .number(100), size: .size24)
      }
      .previewDisplayName("Count Large")
    }
  }
}
