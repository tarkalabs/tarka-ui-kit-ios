//
//  TUIButton.swift
//  
//
//  Created by Gopinath on 13/07/23.
//

import SwiftUI

/// `TUIButton` is a SwiftUI view that acts as a button.
/// The view can be customized with different styles, to configure the title, background colors and sizes
///
/// It has few modifiers to configure its properties. To explore that, please check
/// `TUIButton+Modifiers.swift`
///
public struct TUIButton: View {
  
  var title: String
  var style: Style = .primary
  var size: Size = .regular
  var icon: Icon?
  var badge: String?
  var width: Width = .fill
  
  var action: () -> Void
  
  public init(title: String,
              action: @escaping () -> Void) {
    self.title = title
    self.action = action
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
      .padding(.leading, size.leading(for: icon))
      .padding(.trailing, size.trailing(for: icon))
      .width(width)
    }
    .frame(minHeight: size.height)
    .background(style.backgroundColor)
    .roundedCornerWithBorder(width: style.borderWidth, color: .onSurface)
  }
  
  private func image(for icon: FluentIcon) -> some View {
    Image(fluent: icon)
      .scaledToFit()
      .frame(width: size.iconSize, height: size.iconSize)
      .foregroundColor(style.foregroundColor)
      .clipped()
  }
}

// MARK: - Preview

struct TUIButton_Previews: PreviewProvider {
  
  static var previews: some View {
    
    ForEach(TUIButton.Size.allCases) { size in
      
      VStack(spacing: 40) {
        
        let isLargeIcon: Bool = size == .large || size == .regular
        let icon: FluentIcon = isLargeIcon ? .add24Regular : .add16Regular
        
        ForEach(TUIButton.Style.allCases) { style in
          
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

private extension View {
  
  @ViewBuilder
  func width(_ width: TUIButton.Width) -> some View {
    
    switch width {
    case .fixed(let value):
      self.frame(width: value)
    case .maximum(let value):
      self.frame(maxWidth: value)
    case .fill:
      self
    }
  }
}
