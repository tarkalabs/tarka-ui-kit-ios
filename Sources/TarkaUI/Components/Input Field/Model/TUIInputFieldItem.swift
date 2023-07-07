//
//  TUIInputFieldItem.swift
//  
//
//  Created by Gopinath on 28/06/23.
//

import SwiftUI


/// This is the model class that holds the required values to render `TUIInputField` view
///
public class TUIInputFieldItem: ObservableObject {

  public enum InputFieldStyle {
    case onlyTitle, titleWithValue, onlyValue
  }
  
  /// Decides the style in which `TUIInputFieldItem` to render
  @Published public var style: InputFieldStyle
  
  @Published public var title: String = ""
  @Published public var value: String = ""

  public init(style: InputFieldStyle, title: String = "", value: String = "") {
    self.style = style
    self.title = title
    self.value = value
  }
  
  public var hasTitleAndValue: Bool {
    guard case .titleWithValue = self.style else { return false }
    return true
  }
}
