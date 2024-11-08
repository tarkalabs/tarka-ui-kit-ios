//
//  TUIAppTopBar.swift
//  
//
//  Created by Gopinath on 21/07/23.
//

import SwiftUI

/// `TUIAppTopBar` is a SwiftUI view that acts as a navigation bar for a screen.
/// The view can be customized with title, left and right bar button items and with search
///
/// To configure its properties, please check
/// `TUIAppTopBar+Enums.swift`
///
public struct TUIAppTopBar: View {
  
  var barStyle: BarStyle
  var scanButton: TUIIconButton?
  @ObservedObject var searchBarVM: TUISearchBarViewModel

  @Environment(\.dismiss) private var dismiss

  public init(barStyle: BarStyle, scanButton: TUIIconButton? = nil) {
    self.barStyle = barStyle
    self.scanButton = scanButton
    if case .search(let searchBarItem) = barStyle {
      self.searchBarVM = searchBarItem
    } else {
      self.searchBarVM = TUISearchBarViewModel(
        searchItem: .init(placeholder: "Search", text: "")) { _ in }
    }
  }
  
  public var body: some View {
    
    VStack(spacing: 0) {
      
      let divider = TUIDivider(orientation: .horizontal(hPadding: .zero, vPadding: .zero))
        .color(.surfaceVariantHover)
      
      barView
        .frame(
          maxWidth: .infinity,
          minHeight: barStyle.minHeight - divider.height,
          alignment: .leading)
        .padding(.top, barStyle.topPadding)

      divider
    }
    .background(Color.surface)
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier(Accessibility.root)
  }
  
  @ViewBuilder
  var barView: some View {
    switch barStyle {
      
    case .titleBar(let appBarItem):
      titleBar(using: appBarItem)
      
    case .search(_):
      searchBar()
    }
  }
  @ViewBuilder
  func titleBar(using barItem: TitleBarItem) -> some View {
    
    HStack(spacing: Spacing.halfHorizontal) {
      
      let leftButton = barItem.leftButton
      
      if case .back(let action) = leftButton {
        self.leftButton(icon: .chevronLeft24Regular, action: action)
        
      } else if  case .cancel(let action) = leftButton {
        self.leftButton(icon: .dismiss24Regular, action: action)
      } else if case .custom(let button) = leftButton {
        button
      }
      
      if let titleView = titleView(forBarItem: barItem) {
      titleView
          .lineLimit(2)
          .foregroundColor(.onSurface)
          .font(.heading5)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, leftButton.leading)
          .accessibilityIdentifier(Accessibility.title)
      }

      rightButtons(barItem.rightButtons)
    }
    .padding(.horizontal, Spacing.halfHorizontal)
    .accessibilityIdentifier(Accessibility.titleBar)
  }
  
  func titleView(forBarItem barItem: TitleBarItem) -> Text? {
    if let title = barItem.title {
      return Text(title)
    } else if let attributedTitle = barItem.attributedTitle {
      return Text(attributedTitle)
    }
    return nil
  }
  
  @ViewBuilder
  private func leftButton(icon: FluentIcon, action: TUIButtonAction?) -> some View {
    TUIIconButton(icon: icon) {
      if let action {
        action()
      } else {
        dismiss()
      }
    }
    .style(.ghost)
    .size(.size48)
    .accessibilityIdentifier(Accessibility.leftButton)
  }
  
  @ViewBuilder
  func rightButtons(_ rightButtons: [TUIIconButton]) -> some View {
    
    HStack(spacing: 0) {
      
      ForEach(rightButtons) { button in
        let index = rightButtons.firstIndex { $0.id == button.id } ?? 0
        button
          .size(.size48)
          .accessibilityIdentifier(Accessibility.rightButton(index))
      }
    }
  }
  
  @ViewBuilder
  func searchBar() -> some View {
    TUISearchBar(searchBarVM: searchBarVM)
      .backButton {
        TUIIconButton(icon: .chevronLeft24Regular) {
          searchBarVM.cancelEditing()
        }
        .style(.ghost)
        .size(.size48)
      }
      .isEnabled(true, content: {
        if searchBarVM.isEditing && searchBarVM.isShown && !searchBarVM.searchItem.text.isEmpty {
          return $0.addCancelButtonAtTrailing()
        } else {
          if let scanButton {
            searchBarVM.isScanEnabled = true
            return $0.trailingButton { scanButton }
          }
          return $0.addCancelButtonAtTrailing()
        }
      })
      .padding(.horizontal, Spacing.baseHorizontal)
      .padding(.vertical, Spacing.baseVertical)
  }
}

extension TUIAppTopBar {
  enum Accessibility: TUIAccessibility {
    case root
    case titleBar
    case leftButton
    case title
    case rightButton(Int)
    
    var identifier: String {
      switch self {
      case .root:
        return "TUIAppTopBar"
      case .titleBar:
        return "TitleBar"
      case .leftButton:
        return "LeftButton"
      case .title:
        return "Title"
      case .rightButton(let index):
        return "RightButton - \(index)"
      }
    }
  }
}

struct TUIAppTopBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @StateObject var searchBarVM = TUISearchBarViewModel(
      searchItem: .init(placeholder: "Search", text: "")) { _ in }
    
    let rightButton = TUIIconButton(icon: .circle24Regular) { }
    let leftButtons: [TUIAppTopBar.LeftButton] = [.none, .back({ })]
    
    ScrollView {
      VStack(spacing: 40) {
        
        ForEach(leftButtons, id: \.id) { leftButton in
          
          TUIAppTopBar(
            barStyle: .titleBar(
              .init(
                title: "Title",
                leftButton: leftButton)
            ))
          
          TUIAppTopBar(
            barStyle: .titleBar(
              .init(
                title: "Title",
                leftButton: leftButton,
                rightButtons: [rightButton]))
          )
          
          TUIAppTopBar(
            barStyle: .titleBar(
              .init(
                title: "Title",
                leftButton: leftButton,
                rightButtons: [
                  rightButton, rightButton]))
          )
          TUIAppTopBar(
            barStyle: .titleBar(
              .init(
                title: "Title",
                leftButton: leftButton,
                rightButtons: [
                  rightButton, rightButton, rightButton]))
          )
        }
        .padding(.horizontal, 16)
        
        TUIAppTopBar(barStyle: .search(searchBarVM))
      }
    }
    .padding(.vertical, 20)
  }
}
