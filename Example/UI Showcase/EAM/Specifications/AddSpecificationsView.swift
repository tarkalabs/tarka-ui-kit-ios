//
//  AddSpecificationsView.swift
//  UI Showcase
//
//  Created by Gopinath on 25/08/23.
//

import SwiftUI
import TarkaUI

struct AddSpecificationsView: View {
  
  @State private var navTitleItem: TUIAppTopBar.TitleBarItem = .init(
    title: "Low voltage moulted case",
    leftButton: .back {
      print("Add Spec back clicked")
    })
  
    var body: some View {
      ScrollView {
        VStack(spacing: Spacing.custom(24)) {
          contentView
            .padding(.horizontal, TarkaUI.Spacing.custom(24))
            .padding(.top, TarkaUI.Spacing.custom(15))
          
          TUIDivider(orientation: .horizontal(hPadding: .zero, vPadding: .zero))
            .color(.surfaceVariantHover)
        }
        Spacer()
      }
      .customNavigationBar(titleBarItem: navTitleItem)
    }
  
  @ViewBuilder
  var contentView: some View {
    VStack(spacing:TarkaUI.Spacing.doubleVertical) {
      
      TUITextRow(
        "Classification",
        style: .textDescription(
          "PM / Inspect/Service / Circuit breaker/ Low voltage moulted case"))
        .iconButtons {
          TUIIconButton(icon: .dismiss16Filled) { }
            .iconColor(.outline)
        }
        .wrapperIcon {
          TUIWrapperIcon(icon: .chevronRight20Filled)
        }
      
      TUITextRow("Description", style: .textDescription("Short description goes here"))
      
      TUITextRow("Section", style: .textDescription("All"))
        .wrapperIcon {
          TUIWrapperIcon(icon: .chevronRight20Filled)
        }
    }
  }
}

struct AddSpecificationsView_Previews: PreviewProvider {
    static var previews: some View {
        AddSpecificationsView()
    }
}
