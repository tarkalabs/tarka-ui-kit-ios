//
//  AddSpecificationsView.swift
//  UI Showcase
//
//  Created by Gopinath on 25/08/23.
//

import SwiftUI
import TarkaUI
import Combine

struct AddSpecificationsView: View {
  
  @ObservedObject var vm: SpecificationViewModel
  
  @State var dismissTextFocus: Bool = false
  
  @StateObject var searchBarVM: TUISearchBarViewModel = .init(
    searchItem: .init(placeholder: "Search", text: ""),
    isShown: true) { _ in }
  
  private var navTitleItem: TUIAppTopBar.TitleBarItem {
    
    let syncButton = TUIIconButton(icon: .arrowCounterclockwise24Filled) {
      
    }
    return .init(
      title: "Detail View",
      leftButton: .back(),
      rightButtons: .one(
        syncButton))
  }
  var cancelSet: Set<AnyCancellable> = []
  
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
    .addDoneButtonInToolbar(onClicked: {
      dismissTextFocus = true
      searchBarVM.isEditing = false
    })
    .onReceive(searchBarVM.$isEditing, perform: { isEditing in
      if isEditing {
        dismissTextFocus = true
      }
    })
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
      // revert this variable to false
      self.dismissTextFocus = false
    }
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
      
      TUISearchBar(searchBarVM: searchBarVM)
        .addCancelButtonAtTrailing()
      
      ForEach(vm.addSpecItem.sections, id: \.id) { section in
        view(forSection: section)
      }
    }
  }
  
  @ViewBuilder
  func view(forSection section: AddSpecItem.Section) -> some View {
    
    let specItems = vm.fetchSpecificationForSection(section, searchText: searchBarVM.searchItem.text)
    
    if !specItems.isEmpty {
      TUITextRow(section.displayString,
                 style: .onlyTitle)
      ForEach(specItems, id: \.value) { spec in
        view(forSpec: spec)
      }

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
    
    ForEach(spec.$specAttributes, id: \.id) { attr in
      view(forSpecAttribute: attr)
    }
  }
  
  @ViewBuilder
  func view(forSpecAttribute attr: Binding<SpecAttributeItem>) -> some View {
    
    TUITextInputField(
      inputItem: attr.inputFieldItem)
    .dismissTextFocus(dismissTextFocus)
    .allowedCharacters(CharacterSet(charactersIn: "1234567890."))
    .setKeyboardType(.decimalPad)
  }
  
}

struct AddSpecificationsView_Previews: PreviewProvider {
  static var previews: some View {
    AddSpecificationsView()
  }
}
