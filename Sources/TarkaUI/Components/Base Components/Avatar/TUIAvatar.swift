//
//  TUIAvatar.swift
//
//
//  Created by Arvindh Sukumar on 17/05/23.
//

import SwiftUI

public struct TUIAvatar: View {
  
  // TODO: add size enum

  public enum `Type` {
    case initials(fromString: String)
    case image(Image)
    case icon(FluentIcon)
    // TODO: add URL case
  }
  
  private var type: `Type`
  
  public init(type: `Type`) {
    self.type = type
  }
  
  public var body: some View {
    ZStack {
      Circle()
        .foregroundColor(Color.tertiary)
      
      contentView
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  private var contentView: some View {
    switch type {
    case .initials(let fromString):
      Text(fromString.initials)
        .font(.heading2)
        .foregroundColor(Color.onTertiary)
        .accessibilityIdentifier(Accessibility.label)
    case .image(let image):
      image
        .clipped()
        .accessibilityIdentifier(Accessibility.image)
    case .icon(let icon):
      Image(fluent: icon)
        .clipped()
        .foregroundColor(Color.onTertiary)
        .accessibilityIdentifier(Accessibility.image)
    }
  }
}

extension TUIAvatar {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIAvatar"
    case label = "Label"
    case image = "Image"
  }
}

struct Avatar_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TUIAvatar(type: .initials(fromString: "John Smith"))
      TUIAvatar(type: .icon(.reOrderDotsVertical24Regular))
    }
  }
}
