//
//  TabBar.swift
//
//
//  Created by Arvindh Sukumar on 01/05/23.
//
import SwiftUI

/// A custom TabBar view that displays a list of tabs with a selection indicator.
///
/// The TabBar view takes an array of titles and a binding to a selected tab. The selected tab is highlighted with a selection indicator.
///
/// Example usage:
///
///     TabBar(titles: ["Tab 1", "Tab 2", "Tab 3"], selectedTab: $selectedTab)
///
/// - Parameters:
///   - titles: An array of strings representing the titles of the tabs.
///   - selectedTab: A binding to a string representing the currently selected tab.
///
public struct TabBar: View {
  let titles: [String]
  @Binding var selectedTab: String
  @State private var tabWidths: [CGFloat] = []
  @State private var selectedTabWidth: CGFloat
    
  /// Creates a TabBar view with the specified titles and selected tab.
  ///
  /// - Parameters:
  ///   - titles: An array of strings representing the titles of the tabs.
  ///   - selectedTab: A binding to a string representing the currently selected tab.
  ///
  public init(titles: [String], selectedTab: Binding<String>) {
    self.titles = titles
    self._selectedTab = selectedTab
    self._selectedTabWidth = State(initialValue: 0)
  }
    
  public var body: some View {
    ZStack {
      backgroundView
      tabsView
    }
    .padding(.horizontal, Spacing.baseHorizontal)
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
      ForEach(titles, id: \.self) { title in
        tabView(title)
      }
    }
    .background(alignment: .leading) {
      selectionIndicatorView
    }
    .frame(maxWidth: .infinity)
    .padding(4)
  }
  
  @ViewBuilder
  private func tabView(_ title: String) -> some View {
    Button(action: {
      withAnimation {
        selectedTab = title
      }
    }) {
      Text(title)
        .font(.heading5)
        .padding(.horizontal, Spacing.baseHorizontal)
        .padding(.vertical, Spacing.baseVertical)
        .foregroundColor(selectedTab == title ? .onSecondary : .onSurface)
        .background(GeometryReader { proxy in
          Color.clear
            .preference(key: TabWidthPreferenceKey.self, value: [proxy.size.width])
        })
    }
  }
  
  private var selectionIndicatorView: some View {
    Capsule()
      .frame(width: selectedTabWidth)
      .foregroundColor(.secondaryEAM)
      .offset(x: getOffset(), y: 0)
  }
  
  private func getOffset() -> CGFloat {
    let selectedIndex = titles.firstIndex(of: selectedTab)!
    var offset: CGFloat = 0
    for i in 0 ..< selectedIndex {
      offset += tabWidths[i]
    }
    
    return offset
  }
  
  private func onTabSelection() {
    withAnimation {
      let selectedIndex = titles.firstIndex(of: selectedTab)!
      selectedTabWidth = tabWidths[selectedIndex]
    }
  }
}

private struct TabWidthPreferenceKey: PreferenceKey {
  typealias Value = [CGFloat]
  static var defaultValue: [CGFloat] = []
    
  static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
    value.append(contentsOf: nextValue())
  }
}

struct TabBar_Previews: PreviewProvider {
  static var previews: some View {
    TabBar(titles: ["ABC", "DEF"], selectedTab: .constant("ABC"))
  }
}
