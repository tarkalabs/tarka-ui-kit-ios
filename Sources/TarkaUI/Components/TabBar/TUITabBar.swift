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
  public let count: Int
  public let title: String
  public let icon: FluentIcon?
  
  public init(_ title: String, count: Int = 0, icon: FluentIcon? = nil) {
    self.count = count
    self.title = title
    self.icon = icon
  }
  
  /// **Logical Tab Identification**
  /// Used to maintain consistent tab selection behavior, independent of count changes.
  ///
  /// - Ensures tab selection remains stable even when the tab count updates.
  /// - Without this, a count update can cause the `selectedTab` to become non-matching
  ///   with tabs in the array, leading to potential crashes in `getOffset()` or `onTabSelection()`.
  /// - The `isSameTab()` method provides stable identification by comparing only the tab’s
  ///   title and icon, rather than dynamic properties like count.
  /// - This allows the same logical tab to stay selected regardless of count changes.
  public func isSameTab(as other: TUITabItem) -> Bool {
    return self == other
  }
}

public struct TUITabBar: View {
  private let tabs: [TUITabItem]
  @Binding var selectedTab: TUITabItem
  
  /// Namespace for matched-geometry animation of the selection pill
  @Namespace private var selectionNamespace
  
  /// Creates a TUITabBar view with the specified tabs and selected tab.
  ///
  /// - Parameters:
  ///   - tabs: An array of `TUITabItem` representing the tabs.
  ///   - selectedTab: A binding to a tab representing the currently selected tab.
  ///
  public init(tabs: [TUITabItem], selectedTab: Binding<TUITabItem>) {
    self.tabs = tabs
    _selectedTab = selectedTab
  }
  
  public var body: some View {
    tabsView
      .fixedSize() // To fit the size of the content
  }
  
  @ViewBuilder
  private var tabsView: some View {
    HStack(spacing: 0) {
      ForEach(tabs, id: \.self) { tab in
        tabView(tab)
      }
    }
    .padding(Spacing.halfVertical)
    .background(Color.secondaryAlt, in: .capsule)
  }
  
  @ViewBuilder
  private func tabView(_ tab: TUITabItem) -> some View {
    ZStack {
      if selectedTab == tab {
        Capsule()
          .fill(Color.secondaryTUI)
          .matchedGeometryEffect(id: "selection-pill", in: selectionNamespace)
      }
      TUITab(
        tab: tab,
        isSelected: selectedTab == tab
      ) { tab in
        withAnimation(.smooth) {
          selectedTab = tab
        }
      }
    }
    .clipShape(.capsule)
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
