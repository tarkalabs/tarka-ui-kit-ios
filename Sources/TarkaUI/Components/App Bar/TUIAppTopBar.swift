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
  @ObservedObject var searchBarVM: TUISearchBarViewModel

  public init(barStyle: BarStyle) {
    self.barStyle = barStyle
    if case .search(let searchBarItem) = barStyle {
      self.searchBarVM = searchBarItem
    } else {
      self.searchBarVM = TUISearchBarViewModel(
        searchItem: .init(placeholder: "Search", text: ""))
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
        backButton(action)
      } else if  case .cancel(let action) = leftButton {
        cancelButton(action)
      }
      
      Text(barItem.title)
        .foregroundColor(.onSurface)
        .font(.heading5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, leftButton.leading)
        .accessibilityIdentifier(Accessibility.title)

      rightButtons(using: barItem.rightButtons)
    }
    .padding(.horizontal, Spacing.halfHorizontal)
    .accessibilityIdentifier(Accessibility.titleBar)
  }
  
  @Environment(\.dismiss) private var dismiss

  @ViewBuilder
  private func backButton(_ action: TUIButtonAction?) -> some View {
    
    TUIIconButton(icon: .chevronLeft24Regular) {
      if let action {
        action()
      } else {
        dismiss()
      }
    }
    .style(.ghost)
    .size(.size48)
    .accessibilityIdentifier(Accessibility.backButton)
  }
  
  @ViewBuilder
  private func cancelButton(_ action: TUIButtonAction?) -> some View {
    TUIIconButton(icon: .dismiss24Regular) {
      if let action {
        action()
      } else {
        dismiss()
      }
    }
    .style(.ghost)
    .size(.size48)
    .accessibilityIdentifier(Accessibility.cancelButton)
  }
  
  @ViewBuilder
  func rightButtons(using type: RightButtonType) -> some View {
    
    HStack(spacing: 0) {
      
      switch type {
        
      case .one(let buttonItem):
        buttonItem
          .accessibilityIdentifier(Accessibility.rightButton1)

      case .two(let buttonItem1, let buttonItem2):
        buttonItem1
          .accessibilityIdentifier(Accessibility.rightButton1)
        buttonItem2
          .accessibilityIdentifier(Accessibility.rightButton2)

      case .three(let buttonItem1, let buttonItem2, let buttonItem3):
        buttonItem1
          .accessibilityIdentifier(Accessibility.rightButton1)
        buttonItem2
          .accessibilityIdentifier(Accessibility.rightButton2)
        buttonItem3
          .accessibilityIdentifier(Accessibility.rightButton3)

      case .none:
        EmptyView()
      }
    }
  }
  
  @ViewBuilder
  func searchBar() -> some View {
      
      var searchItem = searchBarVM.searchItem
      
      TUISearchBar(searchBarVM: searchBarVM)
        .backButton {
          TUIIconButton(icon: .chevronLeft24Regular) {
            searchBarVM.isActive = false
            searchBarVM.isEditing = false
            searchItem.text = ""
          }
          .style(.ghost)
          .size(.size40)
        }
        .trailingButton {
          if searchBarVM.isActive, searchBarVM.isEditing,
             !searchItem.text.isEmpty {
            TUIIconButton(icon: .dismiss24Regular) {
              searchBarVM.isEditing = false
            }
            .style(.ghost)
            .size(.size40)
          }
        }
        .padding(.horizontal, Spacing.baseHorizontal)
        .padding(.vertical, Spacing.baseVertical)
    }
}

extension TUIAppTopBar {
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIAppTopBar"
    case titleBar = "TitleBar"
    case backButton = "BackButton"
    case cancelButton = "CancelButton"
    case title = "title"
    case rightButton1 = "RightButton1"
    case rightButton2 = "RightButton2"
    case rightButton3 = "RightButton3"
  }
}

struct TUIAppTopBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @StateObject var searchBarVM = TUISearchBarViewModel(
      searchItem: .init(placeholder: "Search", text: ""))
    
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
                rightButtons: .one(rightButton)))
          )
          
          TUIAppTopBar(
            barStyle: .titleBar(
              .init(
                title: "Title",
                leftButton: leftButton,
                rightButtons: .two(
                  rightButton, rightButton)))
          )
          TUIAppTopBar(
            barStyle: .titleBar(
              .init(
                title: "Title",
                leftButton: leftButton,
                rightButtons: .three(
                  rightButton, rightButton, rightButton)))
          )
        }
        .padding(.horizontal, 16)
        
        TUIAppTopBar(barStyle: .search(searchBarVM))
      }
    }
    .padding(.vertical, 20)
  }
}
