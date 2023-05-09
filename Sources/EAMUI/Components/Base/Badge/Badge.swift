//
//  Badge.swift
//
//
//  Created by Arvindh Sukumar on 25/04/23.
//

import SwiftUI

public struct Badge: View {
  public var count: Int?
  public var size: BadgeSize

  public var body: some View {
    ZStack {
      RoundedRectangle(
        cornerRadius: 100
      )
      .foregroundColor(Color.error)

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

public enum BadgeSize {
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
}

struct Badge_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HStack {
        Badge(size: .s)
        Badge(size: .m)
        Badge(size: .l)
      }
      .previewDisplayName("Plain")

      HStack {
        Badge(count: 1, size: .m)
        Badge(count: 10, size: .m)
        Badge(count: 100, size: .m)
      }
      .previewDisplayName("Count Medium")

      HStack {
        Badge(count: 1, size: .l)
        Badge(count: 10, size: .l)
        Badge(count: 100, size: .l)
      }
      .previewDisplayName("Count Large")
    }
  }
}
