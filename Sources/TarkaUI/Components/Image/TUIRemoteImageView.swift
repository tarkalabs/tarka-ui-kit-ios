//
//  TUIRemoteImageView.swift
//  TarkaUI
//
//  Created by Sujata Shyam on 01/27/26.
//

import SwiftUI
import Kingfisher

public struct TUIRemoteImageView: View {
  
  private let url: URL?
  private let placeholderIcon: FluentIcon
  private let contentMode: SwiftUI.ContentMode
  private let cornerRadius: CGFloat
  private let targetSize: CGSize?
  private let requestHeaders: [String: String]?
  private let requestModifier: AnyModifier?
  private let showsProgress: Bool
  
  public init(
    url: URL?,
    placeholderIcon: FluentIcon = .image32Regular,
    contentMode: SwiftUI.ContentMode = .fit,
    cornerRadius: CGFloat = Spacing.halfHorizontal,
    targetSize: CGSize? = nil,
    requestHeaders: [String: String]? = nil,
    requestModifier: AnyModifier? = nil,
    showsProgress: Bool = true
  ) {
    self.url = url
    self.placeholderIcon = placeholderIcon
    self.contentMode = contentMode
    self.cornerRadius = cornerRadius
    self.targetSize = targetSize
    self.requestHeaders = requestHeaders
    self.requestModifier = requestModifier
    self.showsProgress = showsProgress
  }
  
  public var body: some View {
    contentView
      .frame(width: targetSize?.width, height: targetSize?.height)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
  }

  @ViewBuilder
  private var contentView: some View {
    if let url {
      let image = kfImage(url: url, modifier: effectiveRequestModifier)
      image
        .resizable()
        .aspectRatio(contentMode: contentMode)
    } else {
      placeholderView
    }
  }

  private func kfImage(url: URL, modifier: AnyModifier?) -> KFImage {
    var image = KFImage.url(url)
      .placeholder { placeholderView }
    if let modifier {
      image = image.requestModifier(modifier)
    }
    return image
  }
  
  private var effectiveRequestModifier: AnyModifier? {
    if let requestModifier {
      return requestModifier
    }
    guard let requestHeaders, !requestHeaders.isEmpty else { return nil }
    return AnyModifier { request in
      var modifiedRequest = request
      requestHeaders.forEach { key, value in
        modifiedRequest.setValue(value, forHTTPHeaderField: key)
      }
      return modifiedRequest
    }
  }
  
  @ViewBuilder
  private var placeholderView: some View {
    ZStack {
      Image(fluent: placeholderIcon)
        .foregroundColor(.secondaryTUI)
      if showsProgress {
        ProgressView()
          .tint(.onTertiary)
      }
    }
    .frame(width: targetSize?.width, height: targetSize?.height)
    .background(Color.surfaceVariant)
  }
}
