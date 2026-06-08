//
//  TUIInputFieldItem.swift
//  
//
//  Created by Gopinath on 28/06/23.
//

import SwiftUI

/// This is the model class that defines the style for `TUIInputField` View to render
///
public enum TUIInputFieldStyle {
  case onlyTitle, titleWithValue, onlyValue
}

/// This is the model class that holds the required values to render `TUIInputField` View
///
public struct TUIInputFieldItem: Equatable, Hashable {

  public var style: TUIInputFieldStyle
  public var title: String = ""
  public var value: String = ""
  public var isRequired: Bool = false

  /// Creates a `TUIInputFieldItem` object that holds the required values to render `TUIInputField` View
  /// - Parameters:
  ///   - style: A `InputFieldStyle` instance that holds the style to render its Views
  ///   - title: A string that holds the title
  ///   - value: A string that holds the value ie. content description
  ///   - isRequired: When `true`, renders a red `*` suffix on the title to indicate a mandatory field
  public init(
    style: TUIInputFieldStyle,
    title: String = "", value: String = "",
    isRequired: Bool = false) {

      self.style = style
      self.title = title
      self.value = value
      self.isRequired = isRequired
    }
  
  public var hasTitleAndValue: Bool {
    guard case .titleWithValue = self.style else { return false }
    return true
  }
}
