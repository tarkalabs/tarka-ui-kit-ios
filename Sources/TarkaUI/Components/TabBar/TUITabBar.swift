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
  
  public init(_ title: String, count: Int = 0, icon: FluentIcon? = nil) {
    self.count = count
    self.title = title
    self.icon = icon
  }
  
  public static func == (lhs: TUITabItem, rhs: TUITabItem) -> Bool {
    lhs.title == rhs.title && lhs.icon == rhs.icon
  }
}

public struct TUITabBar: View {
  private let tabs: [TUITabItem]
  @Binding var selectedTab: TUITabItem
  @State private var tabWidths: [CGFloat] = []
  @State private var selectedTabWidth: CGFloat
  
  /// Creates a TUITabBar view with the specified tabs and selected tab.
  ///
  /// - Parameters:
  ///   - tabs: An array of `TUITabItem` representing the tabs.
  ///   - selectedTab: A binding to a tab representing the currently selected tab.
  ///
  public init(tabs: [TUITabItem], selectedTab: Binding<TUITabItem>) {
    self.tabs = tabs
    self._selectedTab = selectedTab
    self._selectedTabWidth = State(initialValue: 0)
  }
  
  public var body: some View {
    ZStack {
      backgroundView
      tabsView
    }
    .fixedSize() // To fit the size of the content
    .frame(maxWidth: .infinity, alignment: .leading) // To left-align the contents
    .onPreferenceChange(TabWidthPreferenceKey.self) {
      tabWidths = $0
    }
    .onAppear {
      onTabSelection()
    }
    .onChange(of: selectedTab) { _ in
      onTabSelection()
    }
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
      }
    }
    .background(alignment: .leading) {
      selectionIndicatorView
    }
    .frame(maxWidth: .infinity)
    .padding(Spacing.halfVertical)
  }
  
  @ViewBuilder
  private func tabView(_ tab: TUITabItem) -> some View {
    TUITab(
      tab: tab,
      isSelected: selectedTab == tab
    ) { tab in
      withAnimation {
        selectedTab = tab
      }
    }
  }
  
  private var selectionIndicatorView: some View {
    Capsule()
      .frame(width: selectedTabWidth)
      .foregroundColor(.secondaryTUI)
      .offset(x: getOffset(), y: 0)
  }
  
  private func getOffset() -> CGFloat {
    guard let selectedIndex = tabs.firstIndex(where: { $0 == selectedTab }) else {
      assertionFailure("Selected tab not matching with the tabs")
      return 0
    }
    var offset: CGFloat = 0
    for i in 0 ..< selectedIndex where tabWidths.count >= selectedIndex {
      offset += tabWidths[i]
    }
    return offset
  }
  
  private func onTabSelection() {
    if let selectedIndex = tabs.firstIndex(where: { $0 == selectedTab }) {
      selectedTabWidth = tabWidths[selectedIndex]
    } else {
      assertionFailure("Selected tab not matching with the tabs")
    }
  }
}

struct TabWidthPreferenceKey: PreferenceKey {
  typealias Value = [CGFloat]
  static var defaultValue: [CGFloat] = []
  
  static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
    value.append(contentsOf: nextValue())
  }
}

struct TabBar_Previews: PreviewProvider {
  
  struct ContainerView: View {
    
    @State private var selectedTab = Tabs.usage.tabItem
    
    var body: some View {
      TUITabBar(tabs: Tabs.allTabs, selectedTab: $selectedTab)
    }
    
    enum Tabs: CaseIterable {
      case usage, reqeust
      
      var tabItem: TUITabItem {
        switch self {
        case .usage: return .init("Usage")
        case .reqeust: return .init("Request")
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
