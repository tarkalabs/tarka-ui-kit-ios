//
//  TUIButton.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

public struct TUIButton: View {
  
  public enum Icon {
    case left(FluentIcon), right(FluentIcon)
  }
  
  var title: String
  var style: TUIButtonStyle = .primary
  var size: TUIButtonSize = .regular
  var icon: Icon?
  var badge: String?
  var width: CGFloat?
  var action: () -> Void
  
  public init(title: String,
              action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }
  
  func image(for icon: FluentIcon) -> some View {
    Image(fluent: icon)
      .scaledToFit()
      .frame(width: size.iconSize, height: size.iconSize)
      .foregroundColor(style.foregroundColor)
      .clipped()
  }
  public var body: some View {
    
    Button(action: action) {
      
      HStack(spacing: size.hStackSpacing) {
        if let icon = icon,
           case .left(let fluentIcon) = icon {
          image(for: fluentIcon)
        }
        Text(title)
          .font(size.buttonSize)
          .foregroundColor(style.foregroundColor)
          .padding(.vertical, size.titleTopPadding)
          .frame(minHeight: size.titleHeight)
        
        if let icon = icon,
           case .right(let fluentIcon) = icon {
          image(for: fluentIcon)
        }
      }
      .padding(.vertical, size.hStackTopPadding)
    }
    .frame(width: width)
    .frame(minHeight: size.height)
    .padding(.leading, size.leading(for: icon))
    .padding(.trailing, size.trailing(for: icon))
    .background(style.backgroundColor)
    .roundedCorner(width: style.borderWidth, color: .onSurface)
  }
}

// MARK: - Preview

extension TUIButton {
  
  @ViewBuilder
  static func constructPreview(_ size: TUIButtonSize) -> some View {
    
    let isLargeIcon: Bool = size == .large || size == .regular
    let icon: FluentIcon = isLargeIcon ? .add24Regular : .add16Regular
    let spacing = 10.0
    
    HStack(spacing: spacing) {
      
      TUIButton(title: "Label") { }
        .style(.primary)
        .size(size)
      
      TUIButton(title: "Label") { }
        .style(.primary)
        .size(size)
        .icon(.right(icon))
      
      TUIButton(title: "Label") { }
        .style(.primary)
        .size(size)
        .icon(.left(icon))
    }
    
    HStack(spacing: spacing) {
      
      TUIButton(title: "Label") { }
        .style(.secondary)
        .size(size)
      
      TUIButton(title: "Label") { }
        .style(.secondary)
        .size(size)
        .icon(.right(icon))
      
      TUIButton(title: "Label") { }
        .style(.secondary)
        .size(size)
        .icon(.left(icon))
    }
    
    HStack(spacing: spacing) {
      
      TUIButton(title: "Label") { }
        .style(.outlined)
        .size(size)
      
      TUIButton(title: "Label") { }
        .style(.outlined)
        .size(size)
        .icon(.right(icon))
      
      TUIButton(title: "Label") { }
        .style(.outlined)
        .size(size)
        .icon(.left(icon))
    }
    
    HStack(spacing: spacing) {
      
      TUIButton(title: "Label") { }
        .style(.ghost)
        .size(size)
      
      TUIButton(title: "Label") { }
        .style(.ghost)
        .size(size)
        .icon(.right(icon))
      
      TUIButton(title: "Label") { }
        .style(.ghost)
        .size(size)
        .icon(.left(icon))
    }
    
    HStack(spacing: spacing) {
      
      TUIButton(title: "Label") { }
        .style(.danger)
        .size(size)
      
      TUIButton(title: "Label") { }
        .style(.danger)
        .size(size)
        .icon(.right(icon))
      
      TUIButton(title: "Label") { }
        .style(.danger)
        .size(size)
        .icon(.left(icon))
    }
  }
}

struct TUIButton_Previews: PreviewProvider {
  
  static var previews: some View {
    
    ForEach(TUIButtonSize.allCases) { size in
      
      VStack(spacing: 40) {
        
        let isLargeIcon: Bool = size == .large || size == .regular
        let icon: FluentIcon = isLargeIcon ? .add24Regular : .add16Regular
        
        ForEach(TUIButtonStyle.allCases) { style in
          
          HStack(spacing: 10.0) {
            
            TUIButton(title: "Label") { }
              .style(style)
              .size(size)
            
            TUIButton(title: "Label") { }
              .style(style)
              .size(size)
              .icon(.right(icon))
            
            TUIButton(title: "Label") { }
              .style(style)
              .size(size)
              .icon(.left(icon))
          }
        }
      }
      .previewDisplayName(size.rawValue)
    }
  }
}
