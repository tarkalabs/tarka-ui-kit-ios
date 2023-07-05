//
//  SwiftUIView.swift
//  
//
//  Created by Gopinath on 28/06/23.
//

import SwiftUI

public class TUIInputFieldItem: ObservableObject {

  public enum InputFieldStyle {
    case onlyTitle, titleWithValue, onlyValue
  }
  
  @Published public var style: InputFieldStyle
  @Published public var title: String = ""
  @Published public var value: String = ""
  @Published var isTextFieldInteractive: Bool = false

  public init(style: InputFieldStyle, title: String = "", value: String = "") {
    self.style = style
    self.title = title
    self.value = value
  }
  
  public var hasContent: Bool {
    guard case .titleWithValue = self.style else { return false }
    return true
  }
}
