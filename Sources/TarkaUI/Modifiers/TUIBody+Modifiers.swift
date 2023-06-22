//
//  TUIBody+Modifiers.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI

extension EnvironmentValues {
  
  var startItem: TUIBody.AdditionalItem {
    get { self[StartItemEnvironmentKey.self] }
    set { self[StartItemEnvironmentKey.self] = newValue }
  }
  
  var endItem: TUIBody.AdditionalItem {
    get { self[EndItemEnvironmentKey.self] }
    set { self[EndItemEnvironmentKey.self] = newValue }
  }
  
  var highlightBar: Bool {
    get { self[HighlightBarEnvironmentKey.self] }
    set { self[HighlightBarEnvironmentKey.self] = newValue }
  }
  
  var helpText: String? {
    get { self[HelpTextEnvironmentKey.self] }
    set { self[HelpTextEnvironmentKey.self] = newValue }
  }
}

struct StartItemEnvironmentKey: EnvironmentKey {
  static var defaultValue = TUIBody.AdditionalItem(item: .text(""))
}

struct EndItemEnvironmentKey: EnvironmentKey {
  static var defaultValue = TUIBody.AdditionalItem(item: .text(""))
}

struct HighlightBarEnvironmentKey: EnvironmentKey {
  static var defaultValue = false
}

struct HelpTextEnvironmentKey: EnvironmentKey {
  static var defaultValue: String? = nil
}

public extension View {
  
  func startItem(_ item: TUIBody.AdditionalItem) -> some View {
    environment(\.startItem, item)
  }
  
  func endItem(_ item: TUIBody.AdditionalItem) -> some View {
    environment(\.endItem, item)
  }

  func highlightBar(_ show: Bool = true) -> some View {
    environment(\.highlightBar, show)
  }
  
  func helpText(_ text: String? = nil) -> some View {
    environment(\.helpText, text)
  }
}
