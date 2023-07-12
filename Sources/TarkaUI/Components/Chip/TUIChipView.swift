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
///        .style(.input(.titleWithButton(Symbol.dismiss)), chipStyle: .size32)
///
///      TUIChipView("Welcome to SwiftUI")
///        .style(filter: .onlyTitle, isSelected: true, chipStyle: .size32)
///
/// - Parameters:
///   - title: This can be any StringProtocol
///
/// - Returns: A closure that returns the content
///
public struct TUIChipView: View {
  
  private var title: any StringProtocol
  private var isSelected: Bool = false
  private var chipStyle: ChipStyle = .size32
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
          .badgeSize(chipStyle == .size32 ? .m : .l)
          .accessibilityIdentifier(Accessibility.badge)
          .alignmentGuide(.top) { $0[.top] + 8 }
          .alignmentGuide(.trailing) { $0[.trailing] - 8 }
      }
    }
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
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
        image, size: chipStyle == .size40 ? Spacing.horizontalMultiple(2) : Spacing.custom(24),
        left: Spacing.quarterHorizontal, right: Spacing.quarterHorizontal)
      
      titleView(left: Spacing.quarterHorizontal, right: Spacing.baseHorizontal)
      
    case .withIcon(let icon):
      leftIconView(
        icon, size: chipStyle == .size32 ? Spacing.custom(20) : Spacing.custom(24),
        left: chipStyle == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal,
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
      leftImageView(
        image, size: chipStyle == .size40 ? Spacing.horizontalMultiple(2) : Spacing.custom(24),
        left: Spacing.quarterHorizontal, right: Spacing.quarterHorizontal)
      
      titleView(left: Spacing.quarterHorizontal, right: Spacing.custom(0))
      rightButtonView(icon, action: action)
      
    case .withLeftIcon(let icon, rightIcon: let rightIcon, let action):
      leftIconView(
        icon, size: chipStyle == .size32 ? Spacing.custom(20) : Spacing.custom(24),
        left: chipStyle == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal,
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
        icon, size: chipStyle == .size32 ? Spacing.custom(20) : Spacing.custom(24),
        left: chipStyle == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal,
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
          chipStyle == .size32 ? .checkmark16Filled : .checkmark20Filled,
          size: chipStyle == .size32 ? Spacing.custom(16) : Spacing.custom(20),
          left: chipStyle == .size32 ? Spacing.custom(6) : Spacing.halfHorizontal,
          right: chipStyle == .size32 ? Spacing.custom(3) : Spacing.quarterHorizontal)
        
        titleView(left: chipStyle == .size32 ? Spacing.custom(3) : Spacing.quarterHorizontal,
                  right: chipStyle == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal)
      } else {
        titleView(left: chipStyle == .size32 ? Spacing.custom(20) : Spacing.custom(28),
                  right: chipStyle == .size32 ? Spacing.custom(20) : Spacing.custom(28))
      }
      
    case .withButton(let icon, let action):
      if isSelected {
        titleView(left: chipStyle == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal,
                  right: Spacing.custom(0))
        rightButtonView(icon) { if let action { action() }}
      } else {
        titleView(left: chipStyle == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal,
                  right: Spacing.custom(0))
        rightButtonView(icon) { if let action { action() }}
      }
      
    case .withIcon(let icon):
      titleView(left: chipStyle == .size32 ? Spacing.custom(12) : Spacing.baseHorizontal,
                right: chipStyle == .size32 ? Spacing.quarterHorizontal : Spacing.custom(5))
      
      rightIconView(
        icon, size: chipStyle == .size32 ? Spacing.baseHorizontal : Spacing.custom(20),
        left: chipStyle == .size32 ? Spacing.quarterHorizontal : Spacing.custom(5),
        right: chipStyle == .size32 ? Spacing.halfHorizontal : Spacing.custom(10))
    }
  }
  
  @ViewBuilder
  private func titleView(left: CGFloat = Spacing.baseHorizontal,
                         right: CGFloat = Spacing.baseHorizontal) -> some View {
    Text(title)
      .font(chipStyle.textSize)
      .frame(maxHeight: chipStyle == .size32 ? Spacing.custom(18) : Spacing.custom(20), alignment: .leading)
      .padding(.trailing, right)
      .padding(.leading, left)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .accessibilityIdentifier(Accessibility.title)
  }
  
  @ViewBuilder
  private func leftImageView(_ image: Image, size: CGFloat,
                             left: CGFloat, right: CGFloat) -> some View {
    image
      .frame(maxWidth: size, maxHeight: size)
      .clipShape(Circle())
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .padding(.leading, left)
      .padding(.trailing, right)
      .accessibilityIdentifier(Accessibility.leftImage)
  }
  
  @ViewBuilder
  private func leftIconView(_ icon: FluentIcon, size: CGFloat,
                            left: CGFloat, right: CGFloat) -> some View {
    Image(fluent: icon)
      .frame(maxWidth: size, maxHeight: size)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .padding(.leading, left)
      .padding(.trailing, right)
      .accessibilityIdentifier(Accessibility.leftIcon)
  }
  
  @ViewBuilder
  private func rightIconView(_ icon: FluentIcon, size: CGFloat,
                             left: CGFloat, right: CGFloat) -> some View {
    Image(fluent: icon)
      .frame(maxWidth: size, maxHeight: size)
      .foregroundColor(isSelected ? .onSecondary : .onSurface)
      .padding(.leading, left)
      .padding(.trailing, right)
      .accessibilityIdentifier(Accessibility.rightIcon)
  }
  
  @ViewBuilder
  private func rightButtonView(_ icon: FluentIcon = .dismiss24Regular,
                               action: (() -> Void)?) -> some View {
    TUIIconButton(icon: icon) {
      if let action { action() }
    }
    .style(.ghost)
    .iconColor(isSelected ? .onSecondary : .onSurface)
    .size(chipStyle == .size32 ? .size24 : .size32)
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
    case size32, size40
    
    var size: CGFloat {
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
  }
  
  enum Style {
    case assist(Assist), input(Input), suggestion(Suggestion), filter(Filter)
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
    case onlyTitle, withButton(icon: FluentIcon, action: (() -> Void)? = nil), withIcon(FluentIcon)
    
    var isBadgeEnabled: Bool {
      switch self {
      case .withButton: return true
      default: return false
      }
    }
    
    var isSelectionEnabled: Bool {
      switch self {
      case .onlyTitle, .withButton: return true
      case .withIcon: return false
      }
    }
  }
}

// MARK: - Modifiers

public extension TUIChipView {
  
  
  /// The style used to display the title with given style options
  /// - Parameters:
  ///   - style: Style can be assist, input, suggestion, Filter
  ///   - chipStyle: size32, size40
  /// - Returns: A closure that returns the TUIChipView
  func style(_ style: Style, chipStyle: ChipStyle = .size40) -> Self {
    var newView = self
    newView.style = style
    newView.chipStyle = chipStyle
    return newView
  }
  
  /// Filter Style used to display chip options with title and button or icon
  /// - Parameters:
  ///   - filter: Choose the list of options to display chip view
  ///   - isSelected: This bool used to select the chip view, applicable for onlyTitle and withButton
  ///   - chipStyle: .size32, size40
  ///   - badgeCount: This is used to display the badge view in top trailing only applicable for withButton type
  ///   - action: This block will execute when view interacted
  /// - Returns: A closure that returns the TUIChipView
  func style(filter: Filter, isSelected: Bool = false,
             chipStyle: ChipStyle = .size40,
             badgeCount: Int = 0,
             action: (() -> Void)? = nil) -> Self {
    var newView = self
    newView.style = Style.filter(filter)
    newView.isSelected = filter.isSelectionEnabled ? isSelected : false
    newView.chipStyle = chipStyle
    newView.badgeCount = filter.isBadgeEnabled ? badgeCount : 0
    newView.action = action
    return newView
  }
}

struct TUIChipView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 10) {
      
      Section("Assist") {
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.onlyTitle), chipStyle: .size32)
        
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.withIcon(.person24Regular)))
        
        TUIChipView("Hello Welcome to swiftUI")
          .style(.assist(.withImage(Image(fluent: .checkmark20Filled))))
      }
      
      Divider()
      
      Section("Input") {
        TUIChipView("Input")
          .style(.input(.titleWithButton(.dismiss24Regular)), chipStyle: .size32)
        
        TUIChipView("Input with Icon")
          .style(.input(.withLeftIcon(.person24Regular, rightIcon: .dismiss24Regular)))
        
        TUIChipView("Input with Image")
          .style(.input(.withLeftImage(Image(fluent: .person24Regular),
                                       rightIcon: .dismiss24Regular)))
      }
      
      Divider()
      
      Section("Suggestion") {
        TUIChipView("Suggestion")
          .style(.suggestion(.onlyTitle), chipStyle: .size32)
        
        TUIChipView("Suggestion with Icon")
          .style(.suggestion(.withIcon(.person24Regular)))
      }
      
      Divider()
      Section("Filter") {
        TUIChipView("Filter")
          .style(filter: .onlyTitle, chipStyle: .size32)
        
        TUIChipView("With Button")
          .style(filter: .withButton(icon: .dismiss24Regular),
                 isSelected: true, chipStyle: .size32, badgeCount: 4)
        
        TUIChipView("With Button")
          .style(filter: .withButton(icon: .dismiss24Regular),
                 isSelected: true, chipStyle: .size40, badgeCount: 5)
        
        TUIChipView("With Button")
          .style(filter: .withIcon(.caretDown16Filled), chipStyle: .size32)
      }
    }
    .padding(.leading, 10)
  }
}

