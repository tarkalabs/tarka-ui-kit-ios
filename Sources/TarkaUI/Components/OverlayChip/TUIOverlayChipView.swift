//
//  TUIOverlayChipView.swift
//
//
//  Created by MAHESHWARAN on 20/10/23.
//

import SwiftUI
import JustifiableFlowLayout

public struct TUIOverlayChipView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @State private var contentHeight = CGFloat.zero
  @State private var headerHeight = CGFloat.zero
  @State private var bottomViewHeight = CGFloat.zero
  
  @State private var records: [RowElement] = []
  @Binding var menuItems: [RowElement]
  
  private var title: String
  
  private var height: CGFloat {
    contentHeight + headerHeight + bottomViewHeight
  }
  
  public init(title: String, menuItems: Binding<[RowElement]>) {
    self.title = title
    _menuItems = menuItems
    _records = .init(initialValue: menuItems.wrappedValue)
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      headerView
      mainView
      bottomView
    }
    .background(Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
    .presentationDetents([.height(height)])
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - Header View
  
  private var headerView: some View {
    TUIOverlayHeaderView(.onlyTitle(title))
      .accessibilityElement(children: .contain)
      .getHeight($headerHeight)
  }
  
  // MARK: - Menu Items View
  
  @ViewBuilder
  private var mainView: some View {
    if !records.isEmpty {
      ScrollView {
        JustifiableFlowLayout {
          chipDetailView
        }
        .padding(.vertical, Spacing.custom(24))
        .padding(.horizontal, Spacing.baseHorizontal)
        .background(Color.surface)
        .getHeight($contentHeight)
      }
      .scrollIndicators(.hidden)
      .frame(maxHeight: contentHeight)
      .accessibilityIdentifier(Accessibility.menuItemView)
      .accessibilityElement(children: .contain)
    }
  }
  
  private var chipDetailView: some View {
    ForEach($records, id: \.id) { button in
      TUIChipView(button.wrappedValue.title)
        .style(filter: button.wrappedValue.style,
               isSelected: button.wrappedValue.isSelected)
        .action {
          button.wrappedValue.isSelected = !button.wrappedValue.isSelected
        }
    }
  }
  
  // MARK: - Bottom View
  
  private var bottomView: some View {
    TUIMobileButtonBlock(style: .two(
      left: .init(title: "Clear".localized) {
        menuItems = records.map {
          var newValue = $0
          newValue.isSelected = false
          return newValue
        }
        dismiss()
      },
      right: .init(title: "Apply".localized) {
        menuItems = records
        dismiss()
      }))
    .getHeight($bottomViewHeight)
  }
}

public extension TUIOverlayChipView {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIOverlayChipView"
    case title = "Title"
    case menuItemView = "Menu Item View"
  }
  
  struct RowElement: Identifiable {
    public var id = UUID().uuidString
    public var title: String
    public var style: TUIChipView.Filter
    public var isSelected = false
    
    public init(
      id: String = UUID().uuidString,
      title: String,
      style: TUIChipView.Filter = .onlyTitle,
      isSelected: Bool = false) {
        self.id = id
        self.title = title
        self.style = style
        self.isSelected = isSelected
      }
  }
}

struct TUIOverlayChipView_Previews: PreviewProvider {
  
  @State static var menuItems = [
    TUIOverlayChipView.RowElement(title: "Hello"),
    .init(title: "Welcome"),
    .init(title: "To"),
    .init(title: "SwiftUI")
  ]
  
  static var previews: some View {
    ZStack {
      Color.gray.opacity(0.3)
        .ignoresSafeArea()
      TUIOverlayChipView(title: "Menu Title", menuItems: $menuItems)
    }
  }
}
