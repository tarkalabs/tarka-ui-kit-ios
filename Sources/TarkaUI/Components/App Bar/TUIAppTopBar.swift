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
  
  public init(barStyle: BarStyle) {
    self.barStyle = barStyle
  }
  
  public var body: some View {
    
    Group {
      
      switch barStyle {
        
      case .titleBar(let appBarItem):
        titleBar(using: appBarItem)
        
      case .search(let searchBarItem):
        searchBar(using: searchBarItem)
      }
    }
    .background(Color.surface)
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
      
      rightButtons(using: barItem.rightButtons)
    }
    .frame(maxWidth: .infinity, minHeight: barStyle.minHeight, alignment: .leading)
    .padding(.horizontal, Spacing.halfHorizontal)
  }
  
  @ViewBuilder
  private func backButton(_ action: @escaping TUIButtonAction) -> TUIIconButton {
    
    TUIIconButton(icon: .chevronLeft24Regular) {
      action()
    }
    .style(.ghost)
    .size(.size48)
  }
  
  @ViewBuilder
  private func cancelButton(_ action: @escaping TUIButtonAction) -> TUIIconButton {
    TUIIconButton(icon: .dismiss24Regular) {
      action()
    }
    .style(.ghost)
    .size(.size48)
  }
  
  @ViewBuilder
  func rightButtons(using type: RightButtonType) -> some View {
    
    HStack(spacing: 0) {
      
      switch type {
        
      case .one(let buttonItem):
        buttonItem
        
      case .two(let buttonItem1, let buttonItem2):
        buttonItem1
        buttonItem2
        
      case .three(let buttonItem1, let buttonItem2, let buttonItem3):
        buttonItem1
        buttonItem2
        buttonItem3
        
      case .none:
        EmptyView()
      }
    }
  }
  
  @ViewBuilder
  func searchBar(
    using searchBarItem: TUISearchBarItem) -> some View {
      
      let searchItem = searchBarItem
      
      TUISearchBar(searchItem: searchItem)
        .backButton {
          TUIIconButton(icon: .chevronLeft24Regular) {
            searchItem.isActive = false
            searchItem.isEditing = false
            searchItem.text = ""
          }
          .style(.ghost)
          .size(.size40)
        }
        .trailingButton {
          if searchItem.isActive, searchItem.isEditing,
             !searchItem.text.isEmpty {
            TUIIconButton(icon: .dismiss24Regular) {
              searchItem.isEditing = false
            }
            .style(.ghost)
            .size(.size40)
          }
        }
        .padding(.horizontal, Spacing.baseHorizontal)
        .padding(.vertical, Spacing.baseVertical)
    }
  
}

struct TUIAppTopBar_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @State var text = ""
    @State var isActive = false
    @State var isEditing = false
    
    let searchItem = TUISearchBarItem(
      placeholder: "Search",
      text: $text, isActive: $isActive, isEditing: $isEditing)
    
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
        
        TUIAppTopBar(barStyle: .search(searchItem))
      }
    }
    .padding(.vertical, 20)
  }
}
