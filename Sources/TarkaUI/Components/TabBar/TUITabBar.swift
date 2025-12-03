//
//  TUITabBar.swift
//
//
//  Created by Arvindh Sukumar on 01/05/23.
//
import SwiftUI

/// A custom TabBar view that displays a list of tabs with a selection indicator.
///
/// The TUITabBar view takes an array of tabs and a binding to a selected tab. The selected tab is highlighted with a selection indicator.
///
/// Example usage:
///
///     TUITabBar(tabs: [.init("Tab 1"), .init("Tab 2")], selectedTab: $selectedTab)
///
/// - Parameters:
///   - tabs: An array of `TUITabItem` representing the tabs.
///   - selectedTab: A binding to a tab representing the currently selected tab.
///

public struct TUITabItem: Hashable {
  public var count: Int
  public let title: String
  public let icon: FluentIcon?
  public let id: String
  
  public init(_ title: String, count: Int = 0, icon: FluentIcon? = nil) {
    self.count = count
    self.title = title
    self.icon = icon
    self.id = title
  }
  
  public static func == (lhs: TUITabItem, rhs: TUITabItem) -> Bool {
    lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

public struct TUITabBar: View {
  private let tabs: [TUITabItem]
  @Binding var selectedTab: TUITabItem
  
  @Namespace private var selectedID
  @State private var selectedItem: TUITabItem?
  
  /// Creates a TUITabBar view with the specified tabs and selected tab.
  ///
  /// - Parameters:
  ///   - tabs: An array of `TUITabItem` representing the tabs.
  ///   - selectedTab: A binding to a tab representing the currently selected tab.
  ///
  public init(tabs: [TUITabItem], selectedTab: Binding<TUITabItem>) {
    self.tabs = tabs
    _selectedTab = selectedTab
    _selectedItem = .init(initialValue: selectedTab.wrappedValue)
  }
  
  public var body: some View {
    ZStack {
      backgroundView
      tabsView
    }
    .fixedSize() // To fit the size of the content
    .frame(maxWidth: .infinity, alignment: .leading) // To left-align the contents
  }
  
  @ViewBuilder
  private var backgroundView: some View {
    Capsule()
      .foregroundColor(.secondaryAlt)
  }
  
  @ViewBuilder
  private var tabsView: some View {
    HStack(spacing: 0) {
      ForEach(tabs, id: \.self) { tab in
        tabView(tab)
          .matchedGeometryEffect(id: tab, in: selectedID)
      }
    }
    .padding(Spacing.halfVertical)
    .background {
      if let selectedItem {
        Capsule()
          .fill(Color.secondaryTUI)
          .matchedGeometryEffect(id: selectedItem, in: selectedID, isSource: false)
      }
    }
  }
  
  @ViewBuilder
  private func tabView(_ tab: TUITabItem) -> some View {
    TUITab(
      tab: tab,
      isSelected: selectedTab.id == tab.id
    ) { tab in
      withAnimation(.smooth) {
        selectedItem = tab
        selectedTab = tab
      }
    }
  }
}

// MARK: - Preview

struct TabBar_Previews: PreviewProvider {
  
  struct ContainerView: View {
    
    @State private var selectedTab = Tabs.usage.tabItem
    
    var body: some View {
      TUITabBar(tabs: Tabs.allTabs, selectedTab: $selectedTab)
    }
    
    enum Tabs: CaseIterable {
      case usage, request, usageDescription
      
      var tabItem: TUITabItem {
        switch self {
        case .usage: return .init("Usage")
        case .request: return .init("Request")
        case .usageDescription: return .init("Usage Description")
        }
      }
      
      static var allTabs: [TUITabItem] {
        Self.allCases.map { $0.tabItem }
      }
    }
  }
  static var previews: some View {
    ContainerView()
  }
}
