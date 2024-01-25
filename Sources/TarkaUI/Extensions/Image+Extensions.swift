//
//  Image+Extensions.swift
//
//
//  Created by Gopinath on 07/07/23.
//

import SwiftUI
import FluentIcons

public typealias FluentIcon = FluentIcons.FluentIcon

public extension Image {
  init(fluent: FluentIcon) {
    self.init(uiImage: UIImage(fluent: fluent))
  }
}


public extension Image {
  
  init(icon: Icon) {
    self.init(icon.rawValue, bundle: .module)
  }
}

public enum Icon: String {
  case checkBoxChecked = "checkbox_checked"
  case checkBoxUnChecked = "checkbox_unchecked"
}
