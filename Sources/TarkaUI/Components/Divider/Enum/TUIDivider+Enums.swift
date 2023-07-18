//
//  TUIDivider+Enums.swift
//  
//
//  Created by Gopinath on 18/07/23.
//

import SwiftUI

public extension TUIDivider {
  
  enum Orientation: CaseIterable {
    
    case horizontal, vertical
  }
  
  enum TBPadding: CaseIterable, Identifiable {
    
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
  
  enum LRPadding: CaseIterable, Identifiable {
    
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
