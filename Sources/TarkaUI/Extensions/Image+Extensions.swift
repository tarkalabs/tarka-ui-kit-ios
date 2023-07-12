//
//  File.swift
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


