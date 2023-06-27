//
//  TUIInputContent.swift
//  
//
//  Created by Gopinath on 27/06/23.
//

import SwiftUI

public enum TUIInputFieldStyle {
  
  case onlyTitle(String)
  case titleWithValue(title: String, value: String)
  case onlyValue(String)
}

struct TUIInputTextContent: View {

  var style: TUIInputFieldStyle
  
  init(style: TUIInputFieldStyle) {
    self.style = style
  }
  
  var body: some View {
    
    VStack(spacing: 2) {
      titleView
        .frame(maxWidth: .infinity, alignment: .leading)
      
      valueView
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(minHeight: height)
  }
  
  @ViewBuilder
  private var titleView: some View {
    switch style {
    case .onlyTitle(let title):
      Text(title)
        .font(.body6)
        .foregroundColor(.inputTextDim)
        .frame(minHeight: 20)
        .frame(alignment: .leading)
//        .accessibilityIdentifier(Accessibility.title)
      
    case .titleWithValue(let title, _):
      Text(title)
        .font(.body8)
        .foregroundColor(.inputTextDim)
        .frame(minHeight: 14)
        .frame(alignment: .leading)
//        .accessibilityIdentifier(Accessibility.title)
      
    default:
       EmptyView()
    }
  }
    
  @ViewBuilder
  private var valueView: some View {
    switch style {
    case .onlyTitle(_):
      EmptyView()
      
    default:
      TextField("BodyValue", text: Binding<String>.constant("""
Input Text
"""), axis: .vertical)
        .labelsHidden()
        .font(.body6)
        .foregroundColor(.inputText)
        .frame(minHeight: 20)
//        .accessibilityIdentifier(Accessibility.title)
    }
  }
  
  var height: CGFloat {
    switch style {
    case .onlyTitle(_):
      return 20
    case .titleWithValue(_,_):
      return 36
    case .onlyValue(_):
      return 20
    }
  }
}

struct TUIInputContent_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 10) {
      Group {
        TUIInputTextContent(style: .onlyTitle("Label"))
        TUIInputTextContent(style: .titleWithValue(title: "Label", value: "Description"))
        TUIInputTextContent(style: .onlyValue("Description"))
      }.border(.blue)
        .padding(.horizontal, 20)
    }
  }
}
