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
///       .badgeSize(.m)
///
/// - Parameters:
///   - count: The count to be displayed in the center of the badge.
///
public struct TUIBadge: View {
  /// The count to be displayed in the center of the badge.
  public var count: Int?
  public var badgeColor: Color?

  @Environment(\.badgeSize) var size

  public var body: some View {
    ZStack {
      Capsule()
        .foregroundColor(badgeColor ?? .error)

      if let count = count {
        Text("\(count)")
          .foregroundColor(.onError)
          .font(font(forSize: size))
          .padding(.horizontal, padding(forSize: size))
          .frame(minWidth: size.width, minHeight: size.height)
      } else {
        Color.clear
          .frame(width: size.width, height: size.height)
      }
    }
    .fixedSize()
  }

  private func font(forSize size: BadgeSize) -> Font {
    switch size {
    case .s, .m:
      return .button8
    case .l:
      return .button7
    }
  }

  private func padding(forSize size: BadgeSize) -> CGFloat {
    switch size {
    case .s:
      return 0
    case .m:
      return 4
    case .l:
      return 8
    }
  }
}

public enum BadgeSize: EnvironmentKey {
  case s, m, l

  private var size: CGSize {
    switch self {
    case .s:
      return CGSize(width: 12, height: 12)
    case .m:
      return CGSize(width: 16, height: 16)
    case .l:
      return CGSize(width: 24, height: 24)
    }
  }

  var width: CGFloat {
    size.width
  }

  var height: CGFloat {
    size.height
  }
  
  public static var defaultValue: BadgeSize = .l
}

struct Badge_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HStack {
        TUIBadge()
      }
      .badgeSize(.m)
      .previewDisplayName("Plain")

      HStack {
        TUIBadge(count: 1)
        TUIBadge(count: 10)
        TUIBadge(count: 100)
      }
      .badgeSize(.m)
      .previewDisplayName("Count Medium")

      HStack {
        TUIBadge(count: 1)
        TUIBadge(count: 10)
        TUIBadge(count: 100)
      }
      .badgeSize(.l)
      .previewDisplayName("Count Large")
    }
  }
}
