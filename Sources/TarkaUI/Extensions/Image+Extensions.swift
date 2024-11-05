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
  
  init(icon: some ImageIconProtocol) {
    self.init(icon.title, bundle: icon.bundle)
  }
}

// MARK: - ImageIconProtocol

public protocol ImageIconProtocol {
  var title: String { get }
  var bundle: Bundle { get }
}

// MARK: - Icon

public enum TUIIcon: String, ImageIconProtocol {
  
  public var bundle: Bundle { .module }
  public var title: String { rawValue }
  
  case checkBoxChecked = "checkbox_checked"
  case checkBoxUnChecked = "checkbox_unchecked"
}

// MARK: - FluentIcon

extension FluentIcon: ImageIconProtocol {
  
  public var bundle: Bundle { UIImage.fluentIconBundle }
  public var title: String { resourceString }
}
