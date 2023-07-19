//
//  TUIButton+Enum.swift
//
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public extension TUIButton {
  
  /// It adds icon in the horizontal stack along with the title
  ///
  /// `left` - sets icon in the left of the title
  ///
  /// `right` - sets icon in the right side of the title
  ///
  enum Icon {
    case left(FluentIcon), right(FluentIcon)
  }
  
  /// It sets the button width
  ///
  /// `fixed` - Makes button width fixed
  ///
  /// `fill` - Auto sets the width according to its size
  ///
  /// `maximum` - Sets the width according to its size but not beyond this value
  ///
  enum Width {
    case fixed(CGFloat)
    case fill
    case maximum(CGFloat)
  }
}
