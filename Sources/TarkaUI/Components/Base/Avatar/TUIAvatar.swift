//
//  TUIAvatar.swift
//
//
//  Created by Arvindh Sukumar on 17/05/23.
//

import SwiftUI

public enum TUIAvatarType {
  case initials(fromString: String)
  case image(Image)
  case icon(Icon)
  // TODO: add URL case
}

public struct TUIAvatar: View {
  public var avatarType: TUIAvatarType
  
  public init(avatarType: TUIAvatarType) {
    self.avatarType = avatarType
  }
  
  public var body: some View {
    ZStack {
      Circle()
        .foregroundColor(Color.tertiary)
      
      contentView
    }
  }
  
  @ViewBuilder
  private var contentView: some View {
    switch avatarType {
    case .initials(let fromString):
      Text(fromString.initials)
        .font(.heading2)
        .foregroundColor(Color.onTertiary)
    case .image(let image):
      image
    case .icon(let icon):
      Image(icon)
        .foregroundColor(Color.onTertiary)
    }
  }
}

struct Avatar_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TUIAvatar(avatarType: .initials(fromString: "John Smith"))
      TUIAvatar(avatarType: .icon(Symbol.reorderDots))
    }
  }
}