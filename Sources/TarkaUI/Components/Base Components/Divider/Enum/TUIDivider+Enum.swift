//
//  TUIDivider+Enum.swift
//  
//
//  Created by Gopinath on 18/07/23.
//

import SwiftUI

public extension TUIDivider {
  
  /// Decides the orientation of the divider
  enum Orientation {
    
    /// Creates horizontal oriented divider with given padding
    /// - Parameters:
    ///   - hPadding: padding to be set for leading or right
    ///   - vPadding: padding to be set for top or bottom
    ///
    case horizontal(hPadding: HorizontalPadding, vPadding: VerticalPadding)
    
    /// Creates vertical oriented divider with given padding
    /// - Parameters:
    ///   - hPadding: padding to be set for leading or right
    ///
    /// It has few restriction on padding in vertical orientation.
    /// Here vertical Padding must be `zero` and horizontal Padding has to be either `zero` or `value 8`.
    /// That's why we use `VerticalPadding` enum for hPadding as it has only `zero` and `value 8` options.
    ///
    case vertical(hPadding: VerticalPadding)
    
    var hPadding: CGFloat {
      
      switch self {
      case .horizontal(let hPadding, _):
        return hPadding.value
      case .vertical(let hPadding):
        return hPadding.value
      }
    }
    
    var vPadding: CGFloat {
      
      switch self {
      case .horizontal(_, let vPadding):
        return vPadding.value
      case .vertical(_):
        return 0
      }
    }
  }
  
  enum VerticalPadding: CaseIterable, Identifiable {
    
    public var id: String {
      UUID().uuidString
    }
    
    case zero, value8
    
    var value: CGFloat {
      
      switch self {
      case .zero: return 0
      case .value8: return 8
      }
    }
  }
  
  enum HorizontalPadding: CaseIterable, Identifiable {
    
    public var id: String {
      UUID().uuidString
    }
    
    case zero, value8, value16, value24, value32
    
    var value: CGFloat {
      switch self {
      case .zero: return 0
      case .value8: return 8
      case .value16: return 16
      case .value24: return 24
      case .value32: return 32
      }
    }
  }
}
