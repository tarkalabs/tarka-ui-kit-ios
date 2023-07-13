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
  
  private var title: any StringProtocol
  private var isSelected: Bool = false
  private var size: Size = .size32
  private var style: Style = .assist(.onlyTitle)
  private var action: (() -> Void)?
  private var badgeCount: Int?
  
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
    .background(isSelected ? Color.secondaryTUI : .surface)
    .overlay(
      RoundedRectangle(cornerRadius: Spacing.halfHorizontal)
        .stroke(Color.outline, lineWidth: isSelected ? 0 : 1.5)
    )
    .cornerRadius(Spacing.halfHorizontal)
    .onTapGesture {
      if let action { action() }
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
      rightButtonView(icon) { if let action { action() } }
      
    case .withLeftImage(let image, rightIcon: let icon, let action):
      leftImageView(image)
      HStack(spacing: Spacing.custom(0)) {
        titleView
        rightButtonView(icon) { if let action { action() } }
      }
      
    case .withLeftIcon(let icon, rightIcon: let rightIcon, let action):
      iconView(icon)
      HStack(spacing: Spacing.custom(0)) {
        titleView
        rightButtonView(rightIcon) { if let action { action() } }
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
        rightButtonView(icon) { if let action { action() }}
      } else {
        titleView
        rightButtonView(icon) { if let action { action() }}
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
                               action: (() -> Void)?) -> some View {
    TUIIconButton(icon: icon) {
      if let action { action() }
    }
    .iconColor(isSelected ? .onSecondary : .onSurface)
    .size(size == .size32 ? .size24 : .size32)
    .accessibilityIdentifier(Accessibility.rightButton)
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
        return size == .size32 ? isSelected ? Spacing.custom(6) : Spacing.quarterHorizontal : isSelected ? Spacing.halfHorizontal : Spacing.quarterHorizontal
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
        return size == .size32 ? isSelected ? Spacing.custom(6) : Spacing.custom(20) : isSelected ? Spacing.halfHorizontal : Spacing.custom(28)
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
        return size == .size32 ? isSelected ? Spacing.custom(12) : Spacing.custom(20) : isSelected ? Spacing.baseHorizontal : Spacing.custom(28)
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
    case rightButton = "rightButton"
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
    case titleWithButton(FluentIcon, action: (() -> Void)? = nil),
         withLeftIcon(FluentIcon, rightIcon: FluentIcon, action: (() -> Void)? = nil),
         withLeftImage(Image, rightIcon: FluentIcon, action: (() -> Void)? = nil)
  }
  
  enum Suggestion {
    case onlyTitle, withIcon(FluentIcon)
  }
  
  enum Filter {
    case onlyTitle, withButton(icon: FluentIcon, action: (() -> Void)? = nil)
  }
  
  enum FilterWithIcon {
    case icon(FluentIcon)
  }
}

// MARK: - Modifiers

public extension TUIChipView {
  
  
  /// The style used to display the title with given style options
  /// - Parameters:
  ///   - style: Style can be assist, input, suggestion, Filter
  ///   - size: size32, size40
  /// - Returns: A closure that returns the TUIChipView
  func style(_ style: Style, size: Size = .size40) -> Self {
    var newView = self
    newView.style = style
    newView.size = size
    return newView
  }
  
  /// Filter Style used to display chip options with title and button or icon
  /// - Parameters:
  ///   - filter: Choose the list of options to display view
  ///   - isSelected: This bool used to select the chip view, applicable for onlyTitle and withButton
  ///   - badgeCount: This is used to display the badge view in top trailing only applicable for withButton type
  ///   - action: This block will execute when view interacted
  /// - Returns: A closure that returns the TUIChipView
  func style(filter: Filter, isSelected: Bool = false,
             badgeCount: Int? = nil, action: (() -> Void)? = nil) -> Self {
    var newView = self
    newView.style = Style.filter(filter)
    newView.isSelected = isSelected
    newView.badgeCount = badgeCount
    newView.action = action
    return newView
  }
  
  func size(_ size: Size) -> Self {
    var newView = self
    newView.size = size
    return newView
  }
  
  func style(for style: FilterWithIcon, action: (() -> Void)? = nil) -> Self {
    var newView = self
    newView.style = Style.filterWithIcon(style)
    newView.action = action
    return newView
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
          .style(.input(.titleWithButton(.dismiss24Regular)), size: .size32)
        
        TUIChipView("Input with Icon")
          .style(.input(.withLeftIcon(.person24Regular, rightIcon: .dismiss24Regular)),
                 size: .size32)
        
        TUIChipView("Input with Image")
          .style(.input(.withLeftImage(Image(fluent: .person24Regular),
                                       rightIcon: .dismiss24Regular)))
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
          .style(filter: .withButton(icon: .dismiss24Filled), isSelected: true)
        
        TUIChipView("With Button")
          .style(filter: .withButton(icon: .dismiss24Filled), isSelected: true, badgeCount: 5)
          .size(.size40)
        
        TUIChipView("With")
          .style(for: .icon(.caretDown16Filled))
      }
    }
    .padding(.leading, 10)
  }
}

