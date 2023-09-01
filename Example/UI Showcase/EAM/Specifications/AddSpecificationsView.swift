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
  
  @State private var showSectionList: Bool = false

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
  
  var bottomBlock: TUIMobileButtonBlock {
    TUIMobileButtonBlock(
    style: .two(
      left: TUIButton(title: "Discard") { },
      right: TUIButton(title: "Add") {
        for section in vm.availableSections {
          let attrs = vm.fetchSpecificationForSection(section)
          let filteredAttrs = attrs.wrappedValue.filter({ !$0.inputFieldItem.value.isEmpty || $0.dateInputFieldItem.date != nil })
          for attr in filteredAttrs {
            var value = attr.inputFieldItem.value
            if value.isEmpty {
              value = attr.dateInputFieldItem.date?.formatted() ?? "No data"
            }
            print("[Spec] Attr title: \(attr.inputFieldItem.title) value: \(value) in section: \(section.displayString)")
          }
        }
      }))
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
    .actionSheet(isPresented: $showSectionList, content: sectionListSheet)
    .customNavigationBar(titleBarItem: navTitleItem)
    .addDoneButtonInToolbar(onClicked: {
      dismissTextFocus = true
      searchBarVM.isEditing = false
    })
    .addBottomMobileButtonBlock(bottomBlock)
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
  
  func sectionListSheet() -> ActionSheet {
    
    var buttons = [ActionSheet.Button]()
    for section in vm.allSections {
      let section = ActionSheet.Button.default(Text(section.displayString)) {
        vm.chosenSection = section
      }
      buttons.append(section)
    }
    // If the cancel label is omitted, the default "Cancel" text will be shown
    let cancel = ActionSheet.Button.cancel(Text("Cancel")) { }
    buttons.append(cancel)

    return ActionSheet(title: Text("Sections"),
                       buttons: buttons)
  }
}

// MARK: - ViewBuilders

extension AddSpecificationsView {
  
  
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
      
      if vm.hasSections {
        Button {
          showSectionList = true
        } label: {
          TUITextRow("Section", style: .textDescription(vm.chosenSection.displayString))
            .wrapperIcon {
              TUIWrapperIcon(icon: .chevronRight20Filled)
            }
        }
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
      
      ForEach(vm.sectionsBasedOnChosen, id: \.id) { section in
        view(forSection: section)
      }
    }
  }
  
  @ViewBuilder
  func view(forSection section: AddSpecItem.Section) -> some View {
    
    let specAttributes = vm.fetchSpecificationForSection(section, searchText: searchBarVM.searchItem.text)
    
    if !specAttributes.isEmpty {
      
      if vm.hasSections {
        TUITextRow(section.displayString,
                   style: .onlyTitle)
      }
      
      ForEach(specAttributes) { specAttr in
        view(forSpecAttribute: specAttr)
      }
    }
  }
  
  @ViewBuilder
  func view(forSpecAttribute attr: Binding<SpecAttributeItem>) -> some View {
    
    let attibute = attr.wrappedValue
    let value = attibute.inputFieldItem.value
    switch attibute.fieldType {
      
    case .lookup:
      
      let style: TUITextRow.Style = value.isEmpty ? .onlyTitle : .textDescription(value)
      TUITextRow(attibute.inputFieldItem.title, style: style)
        .iconButtons {
          TUIIconButton(icon: .dismiss16Filled) { }
            .iconColor(.outline)
        }
        .wrapperIcon {
          TUIWrapperIcon(icon: .chevronRight20Filled)
        }
    case .date:
      TUIDateInputField(
        dateInputItem: attr.dateInputFieldItem)
      
    case .numeric:
      TUITextInputField(
        inputItem: attr.inputFieldItem)
      .dismissTextFocus(dismissTextFocus)
      .allowedCharacters(CharacterSet(charactersIn: "1234567890."))
      .setKeyboardType(.decimalPad)
      
    case .alphaNumeric:
      TUITextInputField(
        inputItem: attr.inputFieldItem)
      .dismissTextFocus(dismissTextFocus)
      .setKeyboardType(.default)
    }
  }
}

struct AddSpecificationsView_Previews: PreviewProvider {
  static var previews: some View {
    AddSpecificationsView()
  }
}
