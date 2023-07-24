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
  enum Icon {
    
    /// Adds icon to the left side of the title
    case left(FluentIcon)
    
    /// Adds icon to the right side of the title
    case right(FluentIcon)
  }
  
  /// Sets the button width
  ///
  enum Width {
    
    /// Makes button width fixed
    case fixed(CGFloat)
    
    /// Auto sets the width according to its size
    case fill
    
    /// Sets the width according to its size but not beyond this value
    case maximum(CGFloat)
  }
}
