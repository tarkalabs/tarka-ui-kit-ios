//
//  TUIChip.swift
//  
//
//  Created by MAHESHWARAN on 05/07/23.
//

import SwiftUI

/// `TUIChip` is a  container view that displays title, image and button
///  This view can be used in any SwiftUI view.
///
/// Example usage:
///
///      TUIChip("Hello")
///        .style(.input(.titleWithButton(Symbol.dismiss)), size: .size32)
///
///      TUIChip("Welcome to SwiftUI")
///        .style(filter: .onlyTitle, isSelected: true, size: .size32)
///
/// - Parameters:
///   - title: This used be display chip title
///
/// - Returns: A closure that returns the content
///
public struct TUIChip: View {
  
  var inputItem: InputItem
  
  public init(_ title: String) {
    self.inputItem = .init(title: title)
  }
  
  public var body: some View {
    Button(action: { inputItem.action?() }) {
      HStack(spacing: spacing) {
        detailView
      }
    }
    .buttonStyle(ChipButtonStyle(inputItem, leading: leading, trailing: trailing))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder private var detailView: some View {
    switch inputItem.style {
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
      if inputItem.isSelected {
        iconView(inputItem.icon)
        titleView
      } else {
        titleView
      }
      
    case .withButton(let icon, let action):
      if inputItem.isSelected {
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
    Text(inputItem.title)
      .font(inputItem.size.font)
      .frame(minHeight: inputItem.size.textSize, alignment: .leading)
      .foregroundColor(inputItem.textTintColor)
      .fixedSize(horizontal: true, vertical: false)
      .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private func leftImageView(_ image: Image) -> some View {
    image
      .frame(maxWidth: inputItem.size.imageSize, maxHeight: inputItem.size.imageSize)
      .clipShape(Circle())
      .foregroundColor(inputItem.tintColor)
      .accessibilityIdentifier(Accessibility.leftImage)
  }
  
  @ViewBuilder
  private func iconView(_ icon: ImageIconProtocol,
                        accessibilityID: Accessibility = .leftIcon) -> some View {
    Image(icon: icon)
      .frame(maxWidth: iconSize, maxHeight: iconSize)
      .foregroundColor(inputItem.tintColor)
      .accessibilityIdentifier(accessibilityID)
  }
  
  @ViewBuilder
  private func rightButtonView(_ icon: FluentIcon = .dismiss16Filled,
                               action: @escaping () -> Void) -> some View {
    TUIIconButton(icon: icon) { action() }
      .iconColor(inputItem.tintColor)
      .size(inputItem.iconSize)
      .accessibilityElement(children: .contain)
      .accessibilityIdentifier(Accessibility.button)
  }
  
  // MARK: - Button Style
  
  struct ChipButtonStyle: ButtonStyle {
    
    let inputItem: InputItem
    let leading: CGFloat
    let trailing: CGFloat
    
    init(_ inputItem: InputItem, leading: CGFloat, trailing: CGFloat) {
      self.inputItem = inputItem
      self.leading = leading
      self.trailing = trailing
    }
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .frame(height: inputItem.size.height)
        .padding(.leading, leading)
        .padding(.trailing, trailing)
        .padding(.vertical, 0)
        .background(backgroundColor(configuration.isPressed), in: .rect(cornerRadius: inputItem.cornerRadius))
        .border(.rect(cornerRadius: inputItem.cornerRadius),
                width: borderWidth(configuration.isPressed), color: inputItem.borderShapeColor)
        .isEnabled(inputItem.isBadgeEnabled) {
          $0.overlay(alignment: .topTrailing, content: badgeView)
        }
        .contentShape(.rect(cornerRadius: inputItem.cornerRadius))
    }
    
    func borderWidth(_ isPressed: Bool) -> CGFloat {
      isPressed ? inputItem.borderWidth + 1 : inputItem.borderWidth
    }
    
    func backgroundColor(_ isPressed: Bool) -> Color {
      isPressed ? inputItem.backgroundColor.opacity(0.5) : inputItem.backgroundColor
    }
    
    @ViewBuilder
    private func badgeView() -> some View {
      TUIBadge(
        style: .number(inputItem.badgeCount),
        badgeColor: inputItem.badgeColor,
        size: inputItem.badgeSize)
      .alignmentGuide(.top) { $0[.top] + 8 }
      .alignmentGuide(.trailing) { $0[.trailing] - 8 }
      .accessibilityIdentifier(Accessibility.badge)
    }
  }
}

// MARK: - Padding

extension TUIChip {
  
  private var spacing: CGFloat {
    switch inputItem.style {
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
        if inputItem.size == .size32 {
          return inputItem.isSelected ? Spacing.custom(6) : Spacing.quarterHorizontal
        } else {
          return inputItem.isSelected ? Spacing.halfHorizontal : Spacing.quarterHorizontal
        }
        
      case .withButton:
        return Spacing.custom(0)
      }
    case .filterWithIcon(let type):
      switch type {
      case .icon: return inputItem.size == .size32 ? Spacing.halfHorizontal : Spacing.custom(10)
      }
    }
  }
  
  private var leading: CGFloat {
    switch inputItem.style {
    case .assist(let type):
      switch type {
      case .onlyTitle: return Spacing.baseHorizontal
      case .withImage: return Spacing.quarterHorizontal
      case .withIcon: return inputItem.size == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal
      }
    case .input(let type):
      switch type {
      case .titleWithButton: return Spacing.custom(12)
      case .withLeftImage: return Spacing.quarterHorizontal
      case .withLeftIcon: return inputItem.size == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal
      }
    case .suggestion(let type):
      switch type {
      case .onlyTitle: return Spacing.baseHorizontal
      case .withIcon: return inputItem.size == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal
      }
    case .filter(let type):
      switch type {
      case .onlyTitle:
        if inputItem.size == .size32 {
          return inputItem.isSelected ? Spacing.custom(6) : Spacing.custom(20)
        } else {
          return inputItem.isSelected ? Spacing.halfHorizontal : Spacing.custom(28)
        }
      case .withButton:
        return inputItem.size == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal
      }
    case .filterWithIcon(let type):
      switch type {
      case .icon: return inputItem.size == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal
      }
    }
  }
  
  private var trailing: CGFloat {
    switch inputItem.style {
    case .assist, .suggestion: return Spacing.baseHorizontal
    case .input: return Spacing.custom(0)
    case .filter(let type):
      switch type {
      case .onlyTitle:
        if inputItem.size == .size32 {
          return inputItem.isSelected ? Spacing.custom(12) : Spacing.custom(20)
        } else {
          return inputItem.isSelected ? Spacing.baseHorizontal : Spacing.custom(28)
        }
      case .withButton:
        return Spacing.custom(0)
      }
    case .filterWithIcon:
      return inputItem.size == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal
    }
  }
  
  private var iconSize: CGFloat {
    switch inputItem.style {
    case .assist, .suggestion, .input, .filter:
      return inputItem.size == .size32 ? Spacing.custom(20) : Spacing.custom(24)
    case .filterWithIcon:
      return inputItem.size == .size32 ? Spacing.baseHorizontal : Spacing.custom(20)
    }
  }
}

extension TUIChip {
  
  struct InputItem {
    var title: String
    var style: Style = .assist(.onlyTitle)
    var size: Size = .size32
    var isSelected: Bool = false
    
    var color = Color.surface
    var selectionColor = Color.secondaryTUI
    
    var foregroundColor = Color.onSurface
    var foregroundSelectionColor = Color.onSecondary
    
    var textColor = Color.onSurface
    var textSelectionColor = Color.onSecondary
    
    var cornerRadius = Spacing.halfHorizontal
    
    var borderColor = Color.outline
    var borderSelectionColor = Color.secondaryTUI
    
    var action: (() -> Void)?
    var badgeCount: Int?
    var badgeColor = Color.error
    
    var backgroundColor: Color {
      isSelected ? selectionColor : color
    }
    
    var borderWidth: CGFloat {
      isSelected ? 0 : 1
    }
    
    var borderShapeColor: Color {
      isSelected ? borderSelectionColor : borderColor
    }
    
    var icon: FluentIcon {
      size == .size32 ? .checkmark16Filled : .checkmark20Filled
    }
    
    var iconSize: TUIIconButton.Size {
      size == .size32 ? .size32 : .size40
    }
    
    var textTintColor: Color {
      isSelected ? textSelectionColor : textColor
    }
    
    var tintColor: Color {
      isSelected ? foregroundSelectionColor : foregroundColor
    }
    
    var badgeSize: TUIBadge.Size {
      size == .size32 ? .size16 : .size24
    }
    
    var isBadgeEnabled: Bool {
      switch style {
      case .filter(let type):
        switch type {
        case .onlyTitle: return false
        case .withButton: return isSelected && badgeCount != nil ? true : false
        }
      default: return false
      }
    }
  }
}

public extension TUIChip {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIChip"
    case title = "Title"
    case leftImage = "LeftImage"
    case leftIcon = "LeftIcon"
    case rightIcon = "RightIcon"
    case button = "Button"
    case badge = "TUIBadge"
  }
  
  enum Size {
    case size32, size40
    
    var height: CGFloat {
      switch self {
      case .size32: return Spacing.horizontalMultiple(2)
      case .size40: return Spacing.custom(40)
      }
    }
    
    var font: Font {
      switch self {
      case .size32: return .button7
      case .size40: return .button6
      }
    }
    
    var textSize: CGFloat {
      switch self {
      case .size32: return Spacing.custom(18)
      case .size40: return Spacing.custom(20)
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

public extension TUIChip {
  
  enum Assist {
    case onlyTitle, withIcon(ImageIconProtocol), withImage(Image)
  }
  
  enum Input {
    case titleWithButton(FluentIcon, action: () -> Void),
         withLeftIcon(ImageIconProtocol, rightIcon: FluentIcon, action: () -> Void),
         withLeftImage(Image, rightIcon: FluentIcon, action: () -> Void)
  }
  
  enum Suggestion {
    case onlyTitle, withIcon(ImageIconProtocol)
  }
  
  enum Filter {
    case onlyTitle, withButton(FluentIcon, action: () -> Void)
  }
  
  enum FilterWithIcon {
    case icon(FluentIcon)
  }
}

struct TUIChip_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 10) {
      
      Section("Assist") {
        TUIChip("Hello Welcome to swiftUI")
          .style(.assist(.onlyTitle), size: .size32)
        
        TUIChip("Hello Welcome to swiftUI")
          .style(.assist(.withIcon(FluentIcon.person24Regular)))
        
        TUIChip("Hello Welcome to swiftUI")
          .style(.assist(.withImage(Image(fluent: FluentIcon.checkmark20Filled))))
      }
      
      Divider()
      
      Section("Input") {
        TUIChip("Input")
          .style(.input(.titleWithButton(.dismiss16Filled, action: {})), size: .size32)
        
        TUIChip("Input with Icon")
          .style(.input(.withLeftIcon(FluentIcon.person24Regular,
                                      rightIcon: .dismiss20Filled, action: {})))
        
        TUIChip("Input with Image")
          .style(.input(.withLeftImage(Image(fluent: FluentIcon.circle32Filled),
                                       rightIcon: .dismiss16Filled, action: {})))
          .size(.size32)
      }
      
      Divider()
      
      Section("Suggestion") {
        TUIChip("Suggestion")
          .style(.suggestion(.onlyTitle), size: .size32)
        
        TUIChip("Suggestion with Icon")
          .style(.suggestion(.withIcon(FluentIcon.person24Regular)))
      }
      
      Divider()
      Section("Filter") {
        TUIChip("Filter")
          .style(filter: .onlyTitle)
        
        TUIChip("With Button")
          .style(filter: .withButton(.dismiss16Filled, action: {}),
                 isSelected: true)
        
        TUIChip("With Button")
          .style(filter: .withButton(.dismiss20Filled, action: {}),
                 isSelected: true, badgeCount: 4)
          .size(.size40)
        
        TUIChip("With")
          .style(.filterWithIcon(.icon(.caretDown16Filled)))
          .size(.size32)
      }
    }
    .padding(.leading, 10)
  }
}
