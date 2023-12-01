//
//  TUIMultiLevelHeaderItem.swift
//  
//
//  Created by Arvindh Sukumar on 01/12/23.
//

import Foundation

public struct TUIMultiLevelHeaderItem {
  var path: [String]
  var isSelectable: Bool = false
  var backButton: TUIIconButton
  
  var pathTitle: String {
    var pathArray: [String]
    if path.count > 2 {
      pathArray = [path.first!, "...", path.last!]
    } else {
      pathArray = path
    }
    
    return pathArray.joined(separator: "/")
  }
  
  public init(path: [String], isSelectable: Bool, backButton: TUIIconButton) {
    self.path = path
    self.isSelectable = isSelectable
    self.backButton = backButton
  }
}
