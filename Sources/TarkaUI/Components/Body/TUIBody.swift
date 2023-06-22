//
//  TUIBody.swift
//  
//
//  Created by Gopinath on 20/06/23.
//

import SwiftUI


public struct TUIBody: View {
  
  public enum Style {
    case noValue(title: String)
    case hasValue(title: String, value: String)
    case compact(value: String)
  }
  
  public enum ItemType {
    case text(String)
    case icon(Icon)
  }
  
  public struct AdditionalItem {
    public var show = true
    public var item: ItemType
    
    public init(show: Bool = true, item: ItemType) {
      self.show = show
      self.item = item
    }
  }
  
  private var style: Style
  @Environment(\.startItem) private var startItem
  @Environment(\.endItem) private var endItem
  @Environment(\.highlightBar) private var highlightBar
  @Environment(\.helpText) private var helpText

  public init(style: Style) {
    self.style = style
    switch style {
    case .hasValue(_, let value), .compact(let value):
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
  private var helperText: some View {
    Text("Helper / hint message goes here.")
      .font(.body8)
      .foregroundColor(.inputTextDim)
      .frame(minHeight: 14)
      .frame(alignment: .leading)
//        .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private var fieldBodyHeaderHStack: some View {
    HStack(alignment: .top, spacing: 8) {
      if startItem.show {
        viewForItem(startItem.item)
          .padding(.leading, 16)
      }
      inputContent
        .frame(maxWidth: .infinity, alignment: .leading)

      if endItem.show {
        viewForItem(endItem.item, isEnd: true)
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
    case .noValue(let title):
      Text(title)
        .font(.body6)
        .foregroundColor(.inputTextDim)
        .frame(minHeight: 20)
        .frame(alignment: .leading)
//        .accessibilityIdentifier(Accessibility.title)
      
    case .hasValue(let title, _):
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
    case .noValue(_):
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
  
//  @ViewBuilder
//  private var helperText: some View {
//
//  }
  
  @ViewBuilder
  private func viewForItem(_ item: ItemType, isEnd: Bool = false) -> some View {
    
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

struct TUIBody_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        TUIBody(style: .noValue(title: "Label"))
          .startItem(.init(item: .text("$")))
          .endItem(.init(item: .text("$")))
        
        TUIBody(style: .noValue(title: "Label"))
          .startItem(.init(item: .icon(Symbol.info)))
          .endItem(.init(item: .icon(Symbol.info)))
        
        TUIBody(style: .noValue(title: "Label"))
          .startItem(.init(item: .text("$")))
          .endItem(.init(item: .icon(Symbol.info)))
        
        TUIBody(style: .noValue(title: "Label"))
          .startItem(.init(item: .icon(Symbol.info)))
          .endItem(.init(item: .text("$")))

      }
      
      VStack {
        TUIBody(style: .hasValue(title: "Label", value: "Input Text"))
          .startItem(.init(item: .text("$")))
          .endItem(.init(item: .text("$")))
        
        TUIBody(style: .hasValue(title: "Label", value: "Input Text"))
          .startItem(.init(item: .icon(Symbol.info)))
          .endItem(.init(item: .icon(Symbol.info)))
        
        TUIBody(style: .hasValue(title: "Label", value: "Input Text"))
          .startItem(.init(item: .text("$")))
          .endItem(.init(item: .icon(Symbol.info)))
        
        TUIBody(style: .hasValue(title: "Label", value: "Input Text"))
          .startItem(.init(item: .icon(Symbol.info)))
          .endItem(.init(item: .text("$")))

      }
      
      VStack {
        TUIBody(style: .compact(value: "Input Text"))
          .startItem(.init(item: .text("$")))
          .endItem(.init(item: .text("$")))
        
        TUIBody(style: .compact(value: "Input Text"))
          .startItem(.init(item: .icon(Symbol.info)))
          .endItem(.init(item: .icon(Symbol.info)))
        
        TUIBody(style: .compact(value: "Input Text"))
          .startItem(.init(item: .text("$")))
          .endItem(.init(item: .icon(Symbol.info)))
        
        TUIBody(style: .compact(value: "Input Text"))
          .startItem(.init(item: .icon(Symbol.info)))
          .endItem(.init(item: .text("$")))

      }
    }
}


extension TUIBody {
  
  var inputViewProperties: (verticalPadding: CGFloat, height: CGFloat) {
    switch style {
    case .noValue(_):
      return (17, 20)
    case .hasValue(_,_):
      return (10, 36)
    case .compact(_):
      return (13, 20)
    }
  }
  
  var fieldBodyHeight: CGFloat {
    switch style {
    case .compact(_):
      return 48
    default:
      return 56
    }
  }
  
  var textItemTopPadding: CGFloat {
    switch style {
    case .noValue(_):
      return 17
    case .hasValue(_,_):
      return 26
    case .compact(_):
      return 13
    }
  }
  
  var iconItemTop: CGFloat {
    
    switch style {
    case .noValue(_):
      return 16
    case .hasValue(_,_):
      return 18
    case .compact(_):
      return 12
    }
  }
}
