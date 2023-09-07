//
//  TUIAttachmentView.swift
//  
//
//  Created by MAHESHWARAN on 24/08/23.
//

import SwiftUI

public struct TUIAttachmentView: View {
  
  private var imageStyle: ImageStyle
  private var imageSize: ImageSize = .size40
  private var style: Style = .onlyTitle
  private var title: String
  
  private var deleteAction: () -> Void
  private var showDownloadButton: Bool = false
  private var downloadAction: (() -> Void)?
  private var iconColor: Color = .secondaryTUI
  
  public init(_ title: String,
              imageStyle: ImageStyle,
              style: TUIAttachmentView.Style = .onlyTitle,
              deleteAction: @escaping () -> Void) {
    self.title = title
    self.imageStyle = imageStyle
    self.style = style
    self.deleteAction = deleteAction
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      HStack(spacing: Spacing.halfHorizontal) {
        imageView
        mainView
      }
      .accessibilityElement(children: .contain)
      if showDownloadButton {
        iconView(.arrowDownload24Regular) { downloadAction?() }
      }
      iconView(.delete24Regular, action: deleteAction)
    }
    .frame(height: Spacing.custom(40))
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  private var mainView: some View {
    VStack(alignment: .leading, spacing: 0) {
      switch style {
      case .onlyTitle: titleView(title)
      case .withDescription(let desc):
        titleView(title)
        detailView(desc)
      }
    }
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder
  private var imageView: some View {
    switch imageStyle {
    case .image(let image):
      image
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: Spacing.halfHorizontal))
        .frame(width: imageSize.width, height: Spacing.custom(40))
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
              .foregroundStyle(iconColor)
        }
        .frame(width: imageSize.width, height: Spacing.custom(40))
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(Accessibility.image)
    }
  }
  
  private func iconView(_ icon: FluentIcon, action: @escaping () -> Void) -> some View {
    TUIIconButton(icon: icon, action: action)
      .size(.size40)
      .iconColor(iconColor)
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

public extension TUIAttachmentView {
  
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
    newView.imageSize = imageSize
    return newView
  }
  
  func download(_ show: Bool, action: @escaping () -> Void) -> Self {
    var newView = self
    newView.showDownloadButton = show
    newView.downloadAction = action
    return newView
  }
  
  func iconColor(_ iconColor: Color) -> Self {
    var newView = self
    newView.iconColor = iconColor
    return newView
  }
  
    
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIAttachmentView"
    case title = "Title"
    case description = "Description"
    case image = "Image"
  }
}

struct TUIAttachmentView_Previews: PreviewProvider {
  static var previews: some View {
    TUIAttachmentView("Hello", imageStyle: .icon(.document24Regular),
                      style: .withDescription("Example")) {}
      .download(true, action: {})
      .padding(.horizontal, 20)
  }
}
