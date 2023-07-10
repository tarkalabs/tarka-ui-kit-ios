//
//  TUIChipView.swift
//  
//
//  Created by MAHESHWARAN on 05/07/23.
//

import SwiftUI

public struct TUIChipView: View {
  
  private var title: any StringProtocol
  private var isSelected: Bool = false
  private var chipStyle: ChipStyle = .l
  private var style: Style = .assist(.onlyTitle)
  private var action: (() -> Void)?
  private var badgeCount: Int = 0
  
  public init(_ title: any StringProtocol) {
    self.title = title
  }
  
  public var body: some View {
    HStack {
      detailView
    }
    .frame(maxHeight: chipStyle.size)
    .background(isSelected ? Color.secondaryTUI : .surface)
    .overlay(
      RoundedRectangle(cornerRadius: Spacing.halfHorizontal)
        .stroke(Color.outline, lineWidth: isSelected ? 0 : 1.5)
    )
    .clipShape(
      RoundedRectangle(cornerRadius: Spacing.halfHorizontal)
    )
    .onTapGesture {
      if let action { action() }
    }
    .isEnabled(isSelected && badgeCount > 0) {
      $0.overlay(alignment: .topTrailing) {
        TUIBadge(count: badgeCount)
          .badgeSize(chipStyle == .s ? .m : .l)
          .alignmentGuide(.top) {
            $0[.top] + 10
          }
          .alignmentGuide(.trailing) {
            $0[.trailing] - 10
          }
      }
    }
  }
  
  @ViewBuilder private var detailView: some View {
    switch style {
    case .assist(let assist): assistView(for: assist)
    case .input(let input): inputView(for: input)
    case .suggestion(let suggestion): suggestionView(for: suggestion)
    case .filter(let filter): filterView(for: filter)
    }
  }
  
  @ViewBuilder
  private func assistView(for type: Assist) -> some View {
    switch type {
    case .onlyTitle: titleView()
      
    case .withImage(let image):
      leftImageView(
        image, size: chipStyle == .l ? Spacing.horizontalMultiple(2) : Spacing.custom(24),
        left: Spacing.quarterHorizontal, right: Spacing.quarterHorizontal)
      
      titleView(left: Spacing.quarterHorizontal, right: Spacing.baseHorizontal)
      
    case .withIcon(let icon):
      leftIconView(
        icon, size: chipStyle == .s ? Spacing.custom(20) : Spacing.custom(24),
        left: chipStyle == .s ? Spacing.custom(6) : Spacing.halfHorizontal,
        right: Spacing.quarterHorizontal)
      
      titleView(left: Spacing.quarterHorizontal, right: Spacing.baseHorizontal)
    }
  }
  
  @ViewBuilder
  private func inputView(for type: Input) -> some View {
    switch type {
    case .titleWithButton(let icon, let action):
      titleView(left: Spacing.custom(12), right: Spacing.custom(0))
      rightButtonView(icon, action: action)
      
    case .withLeftImage(let image, rightIcon: let icon, let action):
      leftImageView(image, left: Spacing.quarterHorizontal, right: Spacing.quarterHorizontal)
      titleView(left: Spacing.quarterHorizontal, right: Spacing.custom(0))
      rightButtonView(icon, action: action)
      
    case .withLeftIcon(let icon, rightIcon: let rightIcon, let action):
      leftIconView(icon, left: chipStyle == .s ? Spacing.custom(6) : Spacing.halfHorizontal,
                   right: Spacing.quarterHorizontal)
      titleView(left: Spacing.quarterHorizontal, right: Spacing.custom(0))
      rightButtonView(rightIcon, action: action)
    }
  }
  
  @ViewBuilder
  private func suggestionView(for type: Suggestion) -> some View {
    switch type {
    case .onlyTitle: titleView()
      
    case .withIcon(let icon):
      leftIconView(
        icon, size: chipStyle == .s ? Spacing.custom(20) : Spacing.custom(24),
        left: chipStyle == .s ? Spacing.custom(6) : Spacing.halfHorizontal,
        right: Spacing.quarterHorizontal)
      
      titleView(left: Spacing.quarterHorizontal, right: Spacing.baseHorizontal)
    }
  }
  
  @ViewBuilder
  private func filterView(for type: Filter) -> some View {
    switch type {
    case .onlyTitle:
      if isSelected {
        leftIconView(
          chipStyle == .s ? Symbol.checkmark16 : Symbol.checkmark20,
          size: chipStyle == .s ? Spacing.custom(20) : Spacing.custom(24),
          left: chipStyle == .s ? Spacing.custom(6) : Spacing.halfHorizontal,
          right: chipStyle == .s ? Spacing.custom(3) : Spacing.quarterHorizontal)
        
        titleView(left: chipStyle == .s ? Spacing.custom(3) : Spacing.quarterHorizontal,
                  right: chipStyle == .s ? Spacing.custom(12) : Spacing.baseHorizontal)
      } else {
        titleView(left: chipStyle == .s ? Spacing.custom(20) : Spacing.custom(28),
                  right: chipStyle == .s ? Spacing.custom(20) : Spacing.custom(28))
      }
      
    case .withButton(let icon, let action):
      if isSelected {
        titleView(left: chipStyle == .s ? Spacing.custom(12) : Spacing.baseHorizontal,
                  right: Spacing.custom(0))
        rightButtonView(icon) { if let action { action() }}
        // badge
      } else {
        titleView(left: chipStyle == .s ? Spacing.custom(12) : Spacing.baseHorizontal,
                  right: Spacing.custom(0))
        rightButtonView(icon) { if let action { action() }}
      }
      
    case .withIcon(let icon):
      titleView(left: chipStyle == .s ? Spacing.custom(12) : Spacing.baseHorizontal,
                right: chipStyle == .s ? Spacing.quarterHorizontal : Spacing.custom(5))
      
      rightIconView(
        icon, size: chipStyle == .s ? Spacing.baseHorizontal : Spacing.custom(20),
        left: chipStyle == .s ? Spacing.quarterHorizontal : Spacing.custom(5),
        right: chipStyle == .s ? Spacing.halfHorizontal : Spacing.custom(10))
    }
  }
  
  @ViewBuilder
  private func titleView(left: CGFloat = Spacing.baseHorizontal,
                         right: CGFloat = Spacing.baseHorizontal) -> some View {
    Text(title)
      .font(chipStyle.textSize)
      .frame(maxHeight: chipStyle == .s ? Spacing.custom(18) : Spacing.custom(20), alignment: .leading)
      .padding(.trailing, right)
      .padding(.leading, left)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private func leftImageView(_ image: Image, size: CGFloat = Spacing.custom(24),
                             left: CGFloat, right: CGFloat) -> some View {
    image
      .frame(maxWidth: size, maxHeight: size)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .padding(.leading, left)
      .padding(.trailing, right)
      .accessibilityIdentifier(Accessibility.leftImage)
  }
  
  @ViewBuilder
  private func leftIconView(_ icon: Icon, size: CGFloat = Spacing.custom(24),
                            left: CGFloat, right: CGFloat) -> some View {
    Image(icon)
      .frame(maxWidth: size, maxHeight: size)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .padding(.leading, left)
      .padding(.trailing, right)
      .accessibilityIdentifier(Accessibility.leftIcon)
  }
  
  @ViewBuilder
  private func rightIconView(_ icon: Icon, size: CGFloat = Spacing.custom(24),
                             left: CGFloat, right: CGFloat) -> some View {
    Image(icon)
      .frame(maxWidth: size, maxHeight: size)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .padding(.leading, left)
      .padding(.trailing, right)
      .accessibilityIdentifier(Accessibility.rightIcon)
  }
  
  @ViewBuilder
  private func rightButtonView(_ icon: Icon = Symbol.dismiss,
                               action: (() -> Void)?) -> some View {
    TUIIconButton(icon: icon) {
      if let action { action() }
    }
    .style(.ghost)
    .iconColor(isSelected ? .onSecondary : .onSurface)
    .size(chipStyle == .s ? .m : .l)
    .accessibilityIdentifier(Accessibility.rightButton)
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
    case badge = "badge"
  }
  
  enum ChipStyle {
    case s, l
    
    var size: CGFloat {
      switch self {
      case .s: return Spacing.horizontalMultiple(2)
      case .l: return Spacing.custom(40)
      }
    }
    
    var textSize: Font {
      switch self {
      case .s: return .button7
      case .l: return .button6
      }
    }
  }
  
  enum Style {
    case assist(Assist), input(Input), suggestion(Suggestion), filter(Filter)
  }
}

public extension TUIChipView {
  
  enum Assist {
    case onlyTitle, withIcon(Icon), withImage(Image)
  }
  
  enum Input {
    case titleWithButton(Icon, action: (() -> Void)? = nil),
         withLeftIcon(Icon, rightIcon: Icon, action: (() -> Void)? = nil),
         withLeftImage(Image, rightIcon: Icon, action: (() -> Void)? = nil)
  }
  
  enum Suggestion {
    case onlyTitle, withIcon(Icon)
  }
  
  enum Filter {
    case onlyTitle, withButton(icon: Icon, action: (() -> Void)? = nil), withIcon(Icon)
  }
}

// MARK: - Modifiers

public extension TUIChipView {
  
  func style(_ style: Style, chipStyle: ChipStyle = .l) -> Self {
    var newView = self
    newView.style = style
    newView.chipStyle = chipStyle
    return newView
  }
  
  func style(filter: Filter, isSelected: Bool = false,
             chipStyle: ChipStyle = .l,
             badgeCount: Int = 0,
             action: (() -> Void)? = nil) -> Self {
    var newView = self
    newView.style = Style.filter(filter)
    newView.isSelected = isSelected
    newView.chipStyle = chipStyle
    newView.badgeCount = badgeCount
    newView.action = action
    return newView
  }
}

struct TUIChipView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 10) {
      
      Section("Assist") {
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.onlyTitle), chipStyle: .s)
        
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.withIcon(Symbol.person)))
        
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.withImage(Image(Symbol.checkmark20))))
      }
      
      Divider()
      
      Section("Input") {
        TUIChipView("Input")
          .style(.input(.titleWithButton(Symbol.dismiss)), chipStyle: .s)
        
        TUIChipView("Input with Icon")
          .style(.input(.withLeftIcon(Symbol.person, rightIcon: Symbol.dismiss)))
        
        TUIChipView("Input with Image")
          .style(.input(.withLeftImage(Image(Symbol.person),
                                       rightIcon: Symbol.dismiss)))
      }
      
      Divider()
      
      Section("Suggestion") {
        TUIChipView("Suggestion")
          .style(.suggestion(.onlyTitle), chipStyle: .s)
        
        TUIChipView("Suggestion with Icon")
          .style(.suggestion(.withIcon(Symbol.person)))
      }
      
      Divider()
      Section("Filter") {
        TUIChipView("Filter")
          .style(filter: .onlyTitle, chipStyle: .s)
        
        TUIChipView("With Button")
          .style(filter: .withButton(icon: Symbol.dismiss, action: {}), isSelected: true, chipStyle: .l, badgeCount: 5, action: {})
        
        TUIChipView("With Button")
          .style(filter: .withIcon(Symbol.caret16),
                 chipStyle: .l, action: {})
      }
    }
    .padding(.leading, 10)
  }
}

