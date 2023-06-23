//
//  TUIInputField.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI


public enum TUIInputFieldConfig {
  case onlyTitle(String)
  case titleWithValue(title: String, value: String)
  case onlyValue(String)
}

public struct TUIInputField: View {
  
  public enum AdditionalItem {
    case text(String)
    case icon(Icon)
  }

  private var style: TUIInputFieldConfig
  var startItem: TUIInputField.AdditionalItem?
  var endItem: TUIInputField.AdditionalItem?
  var highlightBar = false
  var helpText: String?

  public init(style: TUIInputFieldConfig) {
    self.style = style
    switch style {
    case .titleWithValue(_, let value), .onlyValue(let value):
      bodyValue = value
    default: break
    }
  }
  public var body: some View {
    VStack(spacing: 0) {
      fieldBody
        .background(Color.inputBackground)
        .cornerRadius(8)
//      helperText
    }
  }
  
  @ViewBuilder
  private var fieldBody: some View {
    VStack(spacing: 0) {
      
      fieldBodyHeaderHStack
      
      Color.primaryTUI
        .frame(height: 2)
    }
  }

  @ViewBuilder
  private var fieldBodyHeaderHStack: some View {
    
    HStack(alignment: .top, spacing: 8) {
      
      if let startItem {
        viewForItem(startItem)
          .padding(.leading, 16)
      }
      inputContent
        .frame(maxWidth: .infinity, alignment: .leading)

      if let endItem {
        viewForItem(endItem, isEnd: true)
          .padding(.trailing, 16)
      }
    }
    .frame(minHeight: fieldBodyHeight, alignment: .top)
  }
  
  @ViewBuilder
  private var inputContent: some View {
    
    VStack(spacing: 2) {
      titleView
        .frame(maxWidth: .infinity, alignment: .leading)
      
      valueView
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.vertical, inputViewProperties.verticalPadding)
    .frame(minHeight: inputViewProperties.height)
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
  
  @State var bodyValue = ""
  
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
 
  @ViewBuilder
  private func viewForItem(_ item: AdditionalItem, isEnd: Bool = false) -> some View {
    
    switch item {
    case .text(let text):
      Text(text)
        .font(.body5)
        .foregroundColor(.inputTextDim)
        .frame(minHeight: 22)
        .frame(alignment: isEnd ? .trailing : .leading)
        .padding(.top, textItemTopPadding)
//        .accessibilityIdentifier(Accessibility.title)
      
    case .icon(let icon):
      Image(icon)
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
        .foregroundColor(.inputText)
        .padding(.horizontal, Spacing.custom(2.0))
        .padding(.top, iconItemTop + 1)
        .padding(.bottom, 1)
    }
  }
}

struct TUIInputField_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        TUIInputField(style: .onlyTitle("Label"))
          .startItem(.text("$"))
          .endItem(.text("$"))
        
        TUIInputField(style: .onlyTitle("Label"))
          .startItem(.icon(Symbol.info))
          .endItem(.icon(Symbol.info))
        
        TUIInputField(style: .onlyTitle("Label"))
          .startItem(.text("$"))
          .endItem(.icon(Symbol.info))
        
        TUIInputField(style: .onlyTitle("Label"))
          .startItem(.icon(Symbol.info))
          .endItem(.text("$"))
      }
      
      VStack {
        TUIInputField(style: .titleWithValue(title: "Label", value: "Input Text"))
          .startItem(.text("$"))
          .endItem(.text("$"))
        
        TUIInputField(style: .titleWithValue(title: "Label", value: "Input Text"))
          .startItem(.icon(Symbol.info))
          .endItem(.icon(Symbol.info))
        
        TUIInputField(style: .titleWithValue(title: "Label", value: "Input Text"))
          .startItem(.text("$"))
          .endItem(.icon(Symbol.info))
        
        TUIInputField(style: .titleWithValue(title: "Label", value: "Input Text"))
          .startItem(.icon(Symbol.info))
          .endItem(.text("$"))

      }
      
      VStack {
        TUIInputField(style: .onlyValue("Input Text"))
          .startItem(.text("$"))
          .endItem(.text("$"))
        
        TUIInputField(style: .onlyValue("Input Text"))
          .startItem(.icon(Symbol.info))
          .endItem(.icon(Symbol.info))
        
        TUIInputField(style: .onlyValue("Input Text"))
          .startItem(.text("$"))
          .endItem(.icon(Symbol.info))
        
        TUIInputField(style: .onlyValue("Input Text"))
          .startItem(.icon(Symbol.info))
          .endItem(.text("$"))
      }
    }
}


extension TUIInputField {
  
  var inputViewProperties: (verticalPadding: CGFloat, height: CGFloat) {
    switch style {
    case .onlyTitle(_):
      return (17, 20)
    case .titleWithValue(_,_):
      return (10, 36)
    case .onlyValue(_):
      return (13, 20)
    }
  }
  
  var fieldBodyHeight: CGFloat {
    switch style {
    case .onlyValue(_):
      return 48
    default:
      return 56
    }
  }
  
  var textItemTopPadding: CGFloat {
    switch style {
    case .onlyTitle(_):
      return 17
    case .titleWithValue(_,_):
      return 26
    case .onlyValue(_):
      return 13
    }
  }
  
  var iconItemTop: CGFloat {
    
    switch style {
    case .onlyTitle(_):
      return 16
    case .titleWithValue(_,_):
      return 18
    case .onlyValue(_):
      return 12
    }
  }
}
