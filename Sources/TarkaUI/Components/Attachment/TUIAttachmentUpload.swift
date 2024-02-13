//
//  TUIAttachmentUpload.swift
//  
//
//  Created by MAHESHWARAN on 24/08/23.
//

import SwiftUI

public struct TUIAttachmentUpload: View {
  
  private var inputItem: InputItem
  
  public init(_ title: String,
              imageStyle: ImageStyle,
              style: TUIAttachmentUpload.Style = .onlyTitle) {
    inputItem = .init(title: title, imageStyle: imageStyle, imageSize: .size40, style: style)
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      HStack(spacing: Spacing.halfHorizontal) {
        imageView
        mainView
      }
      .accessibilityElement(children: .contain)
      rightView
    }
    .frame(height: Spacing.custom(40))
    .background(Color.surface, in: RoundedRectangle(cornerRadius: 16))
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  private var mainView: some View {
    VStack(alignment: .leading, spacing: 0) {
      switch inputItem.style {
      case .onlyTitle: titleView(inputItem.title)
      case .withDescription(let desc):
        titleView(inputItem.title)
        detailView(desc)
      }
    }
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder
  private var imageView: some View {
    switch inputItem.imageStyle {
    case .image(let image):
      image
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: Spacing.halfHorizontal))
        .frame(width: inputItem.imageSize.width, height: Spacing.custom(40))
        .scaledToFill()
        .accessibilityIdentifier(Accessibility.image)
    
    case .icon(let icon):
      RoundedRectangle(cornerRadius: Spacing.halfHorizontal)
        .fill(Color.surfaceVariant)
        .overlay {
            Image(fluent: icon)
              .scaledToFit()
              .frame(width: Spacing.custom(24), height: Spacing.custom(24))
              .clipped()
              .foregroundStyle(inputItem.imageColor)
        }
        .frame(width: inputItem.imageSize.width, height: Spacing.custom(40))
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(Accessibility.image)
    }
  }
  
  @ViewBuilder
  private var rightView: some View {
    if let downloadIcon = inputItem.downloadIcon, downloadIcon.isEnabled {
      iconView(downloadIcon.icon, color: downloadIcon.iconColor) {
        downloadIcon.action()
      }
    }
    if let deleteIcon = inputItem.deleteIcon, deleteIcon.isEnabled {
      iconView(deleteIcon.icon, color: deleteIcon.iconColor, action: deleteIcon.action)
    }
  }
  
  private func iconView(_ icon: FluentIcon, color: Color, action: @escaping () -> Void) -> some View {
    TUIIconButton(icon: icon, action: action)
      .size(.size40)
      .iconColor(color)
      .accessibilityElement(children: .contain)
  }
  
  private func titleView(_ title: String) -> some View {
    Text(title)
      .font(.body7)
      .foregroundStyle(Color.onSurface)
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: Spacing.custom(18))
      .accessibilityIdentifier(Accessibility.title)
  }
  
  private func detailView(_ title: String) -> some View {
    Text(title)
      .font(.body8)
      .foregroundStyle(Color.inputTextDim)
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: Spacing.custom(14))
      .accessibilityIdentifier(Accessibility.description)
  }
}

public extension TUIAttachmentUpload {
  
  struct InputItem {
    var title: String
    
    var imageStyle: ImageStyle
    var imageSize: ImageSize = .size40
    var imageColor = Color.secondaryTUI
    
    var style: Style = .onlyTitle
    
    var color = Color.surface
    var cornerRadius: CGFloat = 16
    
    var deleteIcon: AttachmentIcon?
    var downloadIcon: AttachmentIcon?
    
    init(title: String, imageStyle: ImageStyle, imageSize: ImageSize, style: Style) {
      self.title = title
      self.imageStyle = imageStyle
      self.imageSize = imageSize
      self.style = style
    }
  }
  
  struct AttachmentIcon {
    var icon: FluentIcon
    var action: () -> Void
    var iconColor = Color.secondaryTUI
    var isEnabled = true
    
    init(_ icon: FluentIcon,
         iconColor: Color = Color.secondaryTUI,
         isEnabled: Bool = true,
         action: @escaping () -> Void) {
      self.icon = icon
      self.action = action
      self.iconColor = iconColor
      self.isEnabled = isEnabled
    }
  }
  
  enum Style {
    case onlyTitle
    case withDescription(String)
  }
  
  enum ImageStyle {
    case image(Image), icon(FluentIcon)
  }
  
  enum ImageSize {
    case size40
    case size60
    
    var width: CGFloat {
      switch self {
      case .size40: return Spacing.custom(52)
      case .size60: return Spacing.custom(53)
      }
    }
  }
  
  func imageSize(_ imageSize: ImageSize) -> Self {
    var newView = self
    newView.inputItem.imageSize = imageSize
    return newView
  }
  
  func download(_ icon: AttachmentIcon) -> Self {
    var newView = self
    newView.inputItem.downloadIcon = icon
    return newView
  }
  
  func deleteIcon(_ icon: AttachmentIcon) -> Self {
    var newView = self
    newView.inputItem.deleteIcon = icon
    return newView
  }
  
  func color(_ color: Color, cornerRadius: CGFloat = 16) -> Self {
    var newView = self
    newView.inputItem.color = color
    newView.inputItem.cornerRadius = cornerRadius
    return newView
  }
  
  func imageColor(_ color: Color) -> Self {
    var newView = self
    newView.inputItem.imageColor = color
    return newView
  }
    
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIAttachmentUpload"
    case title = "Title"
    case description = "Description"
    case image = "Image"
  }
}

struct TUIAttachmentView_Previews: PreviewProvider {
  static var previews: some View {
    TUIAttachmentUpload("Hello", imageStyle: .icon(.document24Regular),
                      style: .withDescription("Example"))
    .download(.init(.arrowDownload24Regular, action: {}))
    .deleteIcon(.init(.delete24Regular, action: {}))
      .padding(.horizontal, 20)
  }
}
