//
//  TUIChipView.swift
//  
//
//  Created by MAHESHWARAN on 05/07/23.
//

import SwiftUI

/// `TUIChipView` is a  container view that displays title, image and button
///  This view can be used in any SwiftUI view.
///
/// Example usage:
///
///      TUIChipView("Hello")
///        .style(.input(.titleWithButton(Symbol.dismiss)), size: .size32)
///
///      TUIChipView("Welcome to SwiftUI")
///        .style(filter: .onlyTitle, isSelected: true, size: .size32)
///
/// - Parameters:
///   - title: This can be any StringProtocol
///
/// - Returns: A closure that returns the content
///
public struct TUIChipView: View {
  
  var title: any StringProtocol
  var isSelected: Bool = false
  var size: Size = .size32
  var style: Style = .assist(.onlyTitle)
  var action: (() -> Void)?
  var badgeCount: Int?
  
  public init(_ title: any StringProtocol) {
    self.title = title
  }
  
  public var body: some View {
    HStack(spacing: spacing) {
      detailView
    }
    .frame(maxHeight: size.height)
    .padding(.leading, leading)
    .padding(.trailing, trailing)
    .padding(.vertical, Spacing.custom(0))
    .background(isSelected ? Color.secondaryTUI : .surface,
                in: RoundedRectangle(cornerRadius: Spacing.halfHorizontal))
    .overlay(content: borderView)
    .onTapGesture {
      action?()
    }
    .overlayViewInTopTrailing(
      isBadgeEnabled, count: badgeCount, badgeSize: size == .size32 ? .m : .l)
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  @ViewBuilder private var detailView: some View {
    switch style {
    case .assist(let assist): assistView(for: assist)
    case .input(let input): inputView(for: input)
    case .suggestion(let suggestion): suggestionView(for: suggestion)
    case .filter(let filter): filterView(for: filter)
    case .filterWithIcon(let filterWithIcon): filterViewWithIcon(for: filterWithIcon)
    }
  }
  
  @ViewBuilder
  private func assistView(for type: Assist) -> some View {
    switch type {
    case .onlyTitle: titleView
      
    case .withImage(let image):
      leftImageView(image)
      titleView
      
    case .withIcon(let icon):
      iconView(icon)
      titleView
    }
  }
  
  @ViewBuilder
  private func inputView(for type: Input) -> some View {
    switch type {
    case .titleWithButton(let icon, let action):
      titleView
      rightButtonView(icon, action: action)
      
    case .withLeftImage(let image, rightIcon: let icon, let action):
      leftImageView(image)
      HStack(spacing: 0) {
        titleView
        rightButtonView(icon, action: action)
      }
      
    case .withLeftIcon(let icon, rightIcon: let righticon, let action):
      iconView(icon)
      HStack(spacing: 0) {
        titleView
        rightButtonView(righticon, action: action)
      }
    }
  }
  
  @ViewBuilder
  private func suggestionView(for type: Suggestion) -> some View {
    switch type {
    case .onlyTitle: titleView
      
    case .withIcon(let icon):
      iconView(icon)
      titleView
    }
  }
  
  @ViewBuilder
  private func filterView(for type: Filter) -> some View {
    switch type {
    case .onlyTitle:
      if isSelected {
        iconView(size == .size32 ? .checkmark16Filled : .checkmark20Filled)
        titleView
      } else {
        titleView
      }
      
    case .withButton(let icon, let action):
      if isSelected {
        titleView
        rightButtonView(icon, action: action)
      } else {
        titleView
        rightButtonView(icon, action: action)
      }
    }
  }
  
  @ViewBuilder
  private func filterViewWithIcon(for type: FilterWithIcon) -> some View {
    switch type {
    case .icon(let icon):
      titleView
      iconView(icon, accessibilityID: .rightIcon)
    }
  }
  
  @ViewBuilder
  private var titleView: some View {
    Text(title)
      .font(size.textSize)
      .frame(maxHeight: size == .size32 ? Spacing.custom(18) : Spacing.custom(20),
             alignment: .leading)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private func leftImageView(_ image: Image) -> some View {
    image
      .frame(maxWidth: size.imageSize, maxHeight: size.imageSize)
      .clipShape(Circle())
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .accessibilityIdentifier(Accessibility.leftImage)
  }
  
  @ViewBuilder
  private func iconView(_ icon: FluentIcon,
                        accessibilityID: Accessibility = .leftIcon) -> some View {
    Image(fluent: icon)
      .frame(maxWidth: iconSize, maxHeight: iconSize)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .accessibilityIdentifier(accessibilityID)
  }
  
  @ViewBuilder
  private func rightButtonView(_ icon: FluentIcon = .dismiss24Regular,
                               action: @escaping () -> Void) -> some View {
    TUIIconButton(icon: icon) { action() }
      .iconColor(isSelected ? .onSecondary : .onSurface)
      .size(size == .size32 ? .size24 : .size32)
  }
  
  @ViewBuilder
  private func borderView() -> some View {
    RoundedRectangle(cornerRadius: Spacing.halfHorizontal)
      .inset(by: isSelected ?  0.75 : 0.5)
      .strokeBorder(Color.outline, lineWidth: isSelected ? 0 : 1)
  }
}

// MARK: - Padding

extension TUIChipView {
  
  private var spacing: CGFloat {
    switch style {
    case .assist(let type):
      switch type {
      case .onlyTitle: return Spacing.quarterHorizontal
      case .withImage, .withIcon: return Spacing.halfHorizontal
      }
    case .input(let type):
      switch type {
      case .titleWithButton: return Spacing.custom(0)
      case .withLeftImage, .withLeftIcon: return Spacing.halfHorizontal
      }
    case .suggestion(let type):
      switch type {
      case .onlyTitle: return Spacing.quarterHorizontal
      case .withIcon: return Spacing.halfHorizontal
      }
    case .filter(let type):
      switch type {
      case .onlyTitle:
        if size == .size32 {
          return isSelected ? Spacing.custom(6) : Spacing.quarterHorizontal
        } else {
          return isSelected ? Spacing.halfHorizontal : Spacing.quarterHorizontal
        }
        
      case .withButton:
        return Spacing.custom(0)
      }
    case .filterWithIcon(let type):
      switch type {
      case .icon: return size == .size32 ? Spacing.halfHorizontal : Spacing.custom(10)
      }
    }
  }
  
  private var leading: CGFloat {
    switch style {
    case .assist(let type):
      switch type {
      case .onlyTitle: return Spacing.baseHorizontal
      case .withImage: return Spacing.quarterHorizontal
      case .withIcon: return size == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal
      }
    case .input(let type):
      switch type {
      case .titleWithButton: return Spacing.custom(12)
      case .withLeftImage: return Spacing.quarterHorizontal
      case .withLeftIcon: return size == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal
      }
    case .suggestion(let type):
      switch type {
      case .onlyTitle: return Spacing.baseHorizontal
      case .withIcon: return size == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal
      }
    case .filter(let type):
      switch type {
      case .onlyTitle:
        if size == .size32 {
          return isSelected ? Spacing.custom(6) : Spacing.custom(20)
        } else {
          return isSelected ? Spacing.halfHorizontal : Spacing.custom(28)
        }
      case .withButton:
        return size == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal
      }
    case .filterWithIcon(let type):
      switch type {
      case .icon: return size == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal
      }
    }
  }
  
  private var trailing: CGFloat {
    switch style {
    case .assist, .suggestion: return Spacing.baseHorizontal
    case .input: return Spacing.custom(0)
    case .filter(let type):
      switch type {
      case .onlyTitle:
        if size == .size32 {
          return isSelected ? Spacing.custom(12) : Spacing.custom(20)
        } else {
          return isSelected ? Spacing.baseHorizontal : Spacing.custom(28)
        }
      case .withButton:
        return Spacing.custom(0)
      }
    case .filterWithIcon:
      return size == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal
    }
  }
  
  private var iconSize: CGFloat {
    switch style {
    case .assist, .suggestion, .input, .filter:
      return size == .size32 ? Spacing.custom(20) : Spacing.custom(24)
    case .filterWithIcon:
      return size == .size32 ? Spacing.baseHorizontal : Spacing.custom(20)
    }
  }
  
  private var isBadgeEnabled: Bool {
    switch style {
    case .filter(let type):
      switch type {
      case .onlyTitle: return false
      case .withButton: return isSelected ? true : false
      }
    default: return false
    }
  }
}

public extension TUIChipView {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIChipView"
    case title = "Title"
    case leftImage = "leftImage"
    case leftIcon = "leftIcon"
    case rightIcon = "rightIcon"
  }
  
  enum Size {
    case size32, size40
    
    var height: CGFloat {
      switch self {
      case .size32: return Spacing.horizontalMultiple(2)
      case .size40: return Spacing.custom(40)
      }
    }
    
    var textSize: Font {
      switch self {
      case .size32: return .button7
      case .size40: return .button6
      }
    }
    
    var imageSize: CGFloat {
      switch self {
      case .size32: return Spacing.custom(24)
      case .size40: return Spacing.horizontalMultiple(2)
      }
    }
  }
  
  enum Style {
    case assist(Assist), input(Input), suggestion(Suggestion), filter(Filter), filterWithIcon(FilterWithIcon)
  }
}

public extension TUIChipView {
  
  enum Assist {
    case onlyTitle, withIcon(FluentIcon), withImage(Image)
  }
  
  enum Input {
    case titleWithButton(FluentIcon, action: () -> Void),
         withLeftIcon(FluentIcon, rightIcon: FluentIcon, action: () -> Void),
         withLeftImage(Image, rightIcon: FluentIcon, action: () -> Void)
  }
  
  enum Suggestion {
    case onlyTitle, withIcon(FluentIcon)
  }
  
  enum Filter {
    case onlyTitle, withButton(FluentIcon, action: () -> Void)
  }
  
  enum FilterWithIcon {
    case icon(FluentIcon)
  }
}

struct TUIChipView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 10) {
      
      Section("Assist") {
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.onlyTitle), size: .size32)
        
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.withIcon(.person24Regular)))
        
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.withImage(Image(fluent: .checkmark20Filled))))
      }
      
      Divider()
      
      Section("Input") {
        TUIChipView("Input")
          .style(.input(.titleWithButton(.dismiss24Regular, action: {})), size: .size32)
        
        TUIChipView("Input with Icon")
          .style(.input(.withLeftIcon(.person24Regular,
                                      rightIcon: .dismiss24Filled, action: {})))
        
        TUIChipView("Input with Image")
          .style(.input(.withLeftImage(Image(fluent: .circle32Filled),
                                       rightIcon: .dismiss24Filled, action: {})))
          .size(.size32)
      }
      
      Divider()
      
      Section("Suggestion") {
        TUIChipView("Suggestion")
          .style(.suggestion(.onlyTitle), size: .size32)
        
        TUIChipView("Suggestion with Icon")
          .style(.suggestion(.withIcon(.person24Regular)))
      }
      
      Divider()
      Section("Filter") {
        TUIChipView("Filter")
          .style(filter: .onlyTitle)
          
        
        TUIChipView("With Button")
          .style(filter: .withButton(.dismiss24Filled, action: {}), isSelected: true)
        
        TUIChipView("With Button")
          .style(filter: .withButton(.dismiss24Filled, action: {}),
                 isSelected: true, badgeCount: 4)
          .size(.size40)
        
        TUIChipView("With")
          .style(.filterWithIcon(.icon(.caretDown16Filled)))
      }
    }
    .padding(.leading, 10)
  }
}
