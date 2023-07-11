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
public class TUIInputFieldItem: ObservableObject {

  @Published public var style: TUIInputFieldStyle
  @Published public var title: String = ""
  @Published public var value: String = ""
  
  /// Creates a `TUIInputFieldItem` object that holds the required values to render `TUIInputField` View
  /// - Parameters:
  ///   - style: A `InputFieldStyle` instance that holds the style to render its Views
  ///   - title: A string that holds the title
  ///   - value: A string that holds the value ie. content description
  public init(
    style: TUIInputFieldStyle,
    title: String = "", value: String = "") {
      
      self.style = style
      self.title = title
      self.value = value
    }
  
  public var hasTitleAndValue: Bool {
    guard case .titleWithValue = self.style else { return false }
    return true
  }
}
