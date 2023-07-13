//
//  TUIButtonSize.swift
//
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public enum TUIButtonSize: String, Identifiable, CaseIterable {
  public var id: String {
    UUID().uuidString
  }
  
  case large, regular, small, xs
  
  func leading(for icon: TUIButton.Icon?) -> CGFloat {
    guard let icon else {
      return paddingWithoutIcon
    }
    switch icon {
    case .right: return paddingWithTitle
    case .left: return paddingWithIcon
    }
  }
  
  func trailing(for icon: TUIButton.Icon?) -> CGFloat {
    
    guard let icon else {
      return paddingWithoutIcon
    }
    switch icon {
    case .right: return paddingWithIcon
    case .left: return paddingWithTitle
    }
  }
  
  var height: CGFloat {
    switch self {
    case .large: return 48
    case .regular: return 40
    case .small: return 32
    case .xs: return 24
    }
  }
  
  var titleHeight: CGFloat {
    switch self {
    case .large, .regular: return 20
    case .small: return 18
    case .xs: return 14
    }
  }
  
  var iconSize: CGFloat {
    switch self {
    case .large, .regular: return 24
    case .small, .xs: return 16
    }
  }
  
  var hStackTopPadding: CGFloat {
    switch self {
    case .large: return 12
    case .regular: return 8
    case .small: return 7
    case .xs: return 5
    }
  }
  
  var hStackSpacing: CGFloat {
    switch self {
    case .large, .regular: return 8
    case .small, .xs: return 4
    }
  }
  
  var titleTopPadding: CGFloat {
    switch self {
    case .large: return 2
    case .regular: return 2
    case .small, .xs: return 0
    }
  }
  
  var buttonSize: Font {
    switch self {
    case .large, .regular: return .button6
    case .small: return .button7
    case .xs: return .button8
    }
  }
  
  private var paddingWithoutIcon: CGFloat {
    switch self {
    case .large: return 24
    case .regular: return 24
    case .small: return 16
    case .xs: return 8
    }
  }
  
  private var paddingWithTitle: CGFloat {
    switch self {
    case .large:  return 24
    case .regular: return 24
    case .small: return 16
    case .xs: return 8
    }
  }
  
  private var paddingWithIcon: CGFloat {
    switch self {
    case .large: return 16
    case .regular: return 16
    case .small: return 8
    case .xs: return 4
    }
  }
}
