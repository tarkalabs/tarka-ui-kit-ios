//
//  AddSpecificationsView.swift
//  UI Showcase
//
//  Created by Gopinath on 25/08/23.
//

import SwiftUI
import TarkaUI


struct AddSpecificationsView: View {
  
  @ObservedObject var vm: SpecificationViewModel
  
  @State var isDoneClicked: Bool = false

  @State private var isActive = false

  @StateObject var searchBarVM: TUISearchBarViewModel = .init(
    searchItem: .init(placeholder: "Search", text: "")) { _ in }

  private var navTitleItem: TUIAppTopBar.TitleBarItem {
    
    let syncButton = TUIIconButton(icon: .arrowCounterclockwise24Filled) {
      isDoneClicked = !isDoneClicked
    }
    return .init(
      title: "Detail View",
      leftButton: .back(),
      rightButtons: .one(
        syncButton))
  }

  init() {
    
    self.vm = SpecificationViewModel()
  }
  
    var body: some View {
      
      ScrollView {
        
        VStack(spacing: Spacing.custom(24)) {
          
          contentView
            .padding(.horizontal, TarkaUI.Spacing.custom(24))
            .padding(.top, TarkaUI.Spacing.doubleVertical)
          
          TUIDivider(orientation: .horizontal(hPadding: .zero, vPadding: .zero))
            .color(.surfaceVariantHover)
          
          headerView
            .padding(.horizontal, TarkaUI.Spacing.custom(24))

        }
        
        Spacer()
      }
      .customNavigationBar(titleBarItem: navTitleItem)
      .addDoneButtonInToolbar(isDoneClicked: $isDoneClicked, onClicked: {
//        if searchBarVM.isEditing {
//          searchBarVM.isEditing = false
//        }
      })
      
    }
  
  @ViewBuilder
  var contentView: some View {
    
    VStack(spacing:TarkaUI.Spacing.doubleVertical) {
      
      TUITextRow(
        "Classification",
        style: .textDescription(
          vm.addSpecItem.classification))
        .iconButtons {
          TUIIconButton(icon: .dismiss16Filled) { }
            .iconColor(.outline)
        }
        .wrapperIcon {
          TUIWrapperIcon(icon: .chevronRight20Filled)
        }
      
      TUITextRow("Description", style: .textDescription(vm.addSpecItem.description))
      
      TUITextRow("Section", style: .textDescription(vm.addSpecItem.sections.first?.displayString ?? ""))
        .wrapperIcon {
          TUIWrapperIcon(icon: .chevronRight20Filled)
        }
      
    }
  }
  
  @ViewBuilder
  var headerView: some View {
    
    VStack(spacing: TarkaUI.Spacing.doubleVertical) {
      
      TUITextRow("Classification specification",
                 style: .onlyTitle)
      
//      TUISearchBar(searchBarVM: searchBarVM)
        
      ForEach(vm.addSpecItem.sections, id: \.id) { section in
        view(forSection: section)
      }
    }
  }
  
  @ViewBuilder
  func view(forSection section: AddSpecItem.Section) -> some View {
    
    TUITextRow(section.displayString,
               style: .onlyTitle)
    let specItems = vm.fetchSpecificationForSection(section)
    
    ForEach(specItems, id: \.value) { spec in
      view(forSpec: spec)
    }
  }
  
  @ViewBuilder
  func view(forSpec spec: SpecificationItem) -> some View {
    
    TUITextRow("Domain", style: .textDescription(spec.value))
      .iconButtons {
        TUIIconButton(icon: .dismiss16Filled) { }
          .iconColor(.outline)
      }
      .wrapperIcon {
        TUIWrapperIcon(icon: .chevronRight20Filled)
      }
    
    ForEach(spec.specAttributes, id: \.id) { attr in
      view(forSpecAttribute: attr)
    }
  }
  
  @State var inputFieldItem = TUIInputFieldItem(style: .onlyTitle, title: "Test")
  
  @ViewBuilder
  func view(forSpecAttribute attr: SpecAttributeItem) -> some View {
    
    TUITextInputField(
      inputItem: $inputFieldItem, isDoneClicked: $isDoneClicked)
    .allowedCharacters(CharacterSet(charactersIn: "1234567890."))
    .setKeyboardType(.decimalPad)
  }

}

struct AddSpecificationsView_Previews: PreviewProvider {
    static var previews: some View {
        AddSpecificationsView()
    }
}
