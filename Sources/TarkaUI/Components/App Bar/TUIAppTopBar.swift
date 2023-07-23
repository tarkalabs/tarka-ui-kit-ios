//
//  TUIAppTopBar.swift
//  
//
//  Created by Gopinath on 21/07/23.
//

import SwiftUI

public struct TUIAppTopBar: View {
  
  var barStyle: BarStyle
  
  @State private var text = ""
  @State private var isEditing = false
  
  public init(barStyle: BarStyle) {
    self.barStyle = barStyle
  }
  
  public var body: some View {
    
    switch barStyle {
      
    case .titleBar(let appBarItem):
      titleBar(using: appBarItem)
        .background(Color.surface)
      
    case .search(let searchItem):
      searchBar(using: searchItem)
    }
  }
  
  
  @ViewBuilder
  func titleBar(using barItem: BarItem) -> some View {
    
    HStack(spacing: 8) {
      let leftButton = barItem.leftButton
      
      if leftButton == .back  {
        backButton()
      } else if leftButton == .cancel  {
        cancelButton()
      }
      Text(barItem.title)
        .foregroundColor(.onSurface)
        .font(.heading5)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      rightButtons(using: barItem.rightButtons)
    }
    .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
    
  }
  
  @ViewBuilder
  private func backButton() -> TUIIconButton {
    
    TUIIconButton(icon: .chevronLeft24Regular) {
      // back
    }
    .style(.ghost)
    .size(.size48)
  }
  
  @ViewBuilder
  private func cancelButton() -> TUIIconButton {
    TUIIconButton(icon: .dismiss24Regular) {
      // cancel
    }
    .style(.ghost)
    .size(.size48)
  }
  
  @ViewBuilder
  func rightButtons(using type: RightButtonType) -> some View {
    
    HStack(spacing: 0) {
      
      switch type {
        
      case .one(let buttonItem):
        buttonItem.button
        
      case .two(let buttonItem1, let buttonItem2):
        buttonItem1.button
        buttonItem2.button
        
      case .three(let buttonItem1, let buttonItem2, let buttonItem3):
        buttonItem1.button
        buttonItem2.button
        buttonItem3.button
        
      case .none:
        EmptyView()
      }
    }
  }
  
  @ViewBuilder
  func searchBar(using searchItem: TUISearchItem) -> some View {
    
    TUISearchBar(searchItem: searchItem)
      .backButton {
        TUIIconButton(icon: .chevronLeft24Regular) { }
          .style(.ghost)
          .size(.size40)
      }
      .trailingButton {
        if searchItem.isEditing {
          TUIIconButton(icon: .dismiss24Regular) {
            searchItem.isEditing = false
          }
            .style(.ghost)
            .size(.size40)
        }
      }
      .padding(.horizontal, 8)
      .padding(.vertical, 8)
  }
  
  var minHeight: CGFloat {
    
    if case .titleBar(let barItem) = barStyle {
      
      if case .none = barItem.leftButton ,
         case .none = barItem.rightButtons {
        return 60
      }
    }
    return 64
  }
}

struct TUIAppTopBar_Previews: PreviewProvider {
  static var previews: some View {
    
    @State var text = ""
    @State var isEditing = false
    
    let searchItem = TUISearchItem(placeholder: "Search", text: $text, isEditing: $isEditing)
    
    let rightButton = TUIIconButton(icon: .circle24Regular) { }
    let leftButtons: [TUIAppTopBar.LeftButton] = [.none, .back]
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
                rightButtons: .one(
                  .init(button: rightButton))))
          )
          
          TUIAppTopBar(
            barStyle: .titleBar(
              .init(
                title: "Title",
                leftButton: leftButton,
                rightButtons: .two(
                  .init(button: rightButton),
                  .init(button: rightButton))))
          )
          TUIAppTopBar(
            barStyle: .titleBar(
              .init(
                title: "Title",
                leftButton: leftButton,
                rightButtons: .three(
                  .init(button: rightButton),
                  .init(button: rightButton),
                  .init(button: rightButton))))
          )
        }
        .padding(.horizontal, 16)
      }
    }
    .padding(.vertical, 20)
    
    VStack {
      
      TUIAppTopBar(barStyle: .search(searchItem))
        .padding(.horizontal, 16)
    }.frame(maxHeight: .infinity, alignment: .top)
  }
}
