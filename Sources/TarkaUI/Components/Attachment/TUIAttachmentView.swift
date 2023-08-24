//
//  TUIAttachmentView.swift
//  
//
//  Created by MAHESHWARAN on 24/08/23.
//

import SwiftUI

public struct TUIAttachmentView: View {
  
  private var imageSize: ImageSize = .size40
  private var style: Style = .onlyTitle
  private var title: String
  private var image: Image
  private var deleteAction: () -> Void
  private var isDownloadEnabled: Bool = false
  private var downloadAction: (() -> Void)?
  private var iconColor: Color = .secondaryTUI
  
  public init(_ title: String,
              image: Image,
              style: TUIAttachmentView.Style,
              deleteAction: @escaping () -> Void) {
    self.title = title
    self.image = image
    self.style = style
    self.deleteAction = deleteAction
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      HStack(spacing: Spacing.halfHorizontal) {
        imageView
        mainView
      }
      if isDownloadEnabled {
        iconView(.arrowDown24Regular) { downloadAction?() }
      }
      iconView(.delete24Regular, action: deleteAction)
    }
    .frame(height: Spacing.custom(40))
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
  }
  
  private var imageView: some View {
    image
      .resizable()
      .scaledToFit()
      .frame(width: imageSize.width, height: Spacing.custom(40))
      .clipShape(RoundedRectangle(cornerRadius: Spacing.halfHorizontal))
  }
  
  private func iconView(_ icon: FluentIcon, action: @escaping () -> Void) -> some View {
    TUIIconButton(icon: icon, action: action)
      .size(.size40)
      .iconColor(iconColor)
  }
  
  private func titleView(_ title: String) -> some View {
    Text(title)
      .font(.body7)
      .foregroundStyle(Color.onSurface)
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: Spacing.custom(18))
  }
  
  private func detailView(_ title: String) -> some View {
    Text(title)
      .font(.body8)
      .foregroundStyle(Color.inputTextDim)
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: Spacing.custom(14))
  }
  
}

public extension TUIAttachmentView {
  
  enum Style {
    case onlyTitle
    case withDescription(String)
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
  
  func imageSize(_ imageSize: ImageSize) -> some View {
    var newView = self
    newView.imageSize = imageSize
    return newView
  }
  
  func download(_ show: Bool, action: @escaping () -> Void) -> some View {
    var newView = self
    newView.isDownloadEnabled = show
    newView.downloadAction = action
    return newView
  }
}

struct TUIAttachmentView_Previews: PreviewProvider {
  static var previews: some View {
    TUIAttachmentView("Hello", image: .init(fluent: .document24Regular),
                      style: .withDescription("Example")) {}
      .download(true, action: {})
      .padding(.horizontal, 20)
  }
}
