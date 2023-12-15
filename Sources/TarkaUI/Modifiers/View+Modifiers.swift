//
//  View+Modifiers.swift
//
//
//  Created by MAHESHWARAN on 03/08/23.
//

import SwiftUI

public extension View {
  
  /// List Row Insets used to create a new view based on the padding amount
  /// - Parameters:
  ///   - vertical: vertical padding amount
  ///   - horizontal: horizontal padding amount
  /// - Returns: A view that's padded by the amount you specify.
  ///
  func listRowInsets(_ vertical: CGFloat, _ horizontal: CGFloat) -> some View {
    self.listRowInsets(EdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal))
  }
  
  /// This method is used to create content Unavailable View in any swiftUI views
  ///
  /// Example usage:
  ///
  ///      Color.gray.opacity(0.4)
  ///         .contentUnavailableView(.init("No Work type", icon: .errorCircle24Regular), show: false)
  ///
  @ViewBuilder
  func contentUnavailableView(_ content: TUIContentUnavailableView, show: Bool = true) -> some View {
    if show {
      content
    } else {
      self
    }
  }
  
  /// Calculates and returns height of the view
  /// - Parameter height: calculated height
  /// - Returns: self with background added with clear color layer
  ///
  func getHeight(_ height: Binding<CGFloat>) -> some View {
    background(
      GeometryReader { proxy in
        Color.clear
          .preference(key: HeightKey.self, value: proxy.size.height)
      }
        .onPreferenceChange(HeightKey.self) { value in
          height.wrappedValue = value
        }
    )
  }
  
  /// Calculates and returns width of the view
  /// - Parameter width: calculated width
  /// - Returns: self with background added with clear color layer
  ///
  func getWidth(_ width: Binding<CGFloat>) -> some View {
    background(
      GeometryReader { proxy in
        Color.clear
          .preference(key: WidthKey.self, value: proxy.size.width)
      }
        .onPreferenceChange(WidthKey.self) { value in
          width.wrappedValue = value
        }
    )
  }
  
  // MARK: - TextRow with Navigation
  
  /// This method is used to create navigationTextRow View with title and optional description, used in any swiftUI views
  ///
  @ViewBuilder
  func navigationTextRow(
    _ title: String,
    style: TUITextRow.Style,
    destinationView: @autoclosure @escaping () -> some View,
    accessibilityID: TUIAccessibility,
    isEnabled: Bool = true,
    @TUIIconButtonBuilder iconButtons: @escaping () -> [TUIIconButton]) -> some View {
      let textRow = TUITextRow(title, style: style)
      
      if isEnabled {
        NavigationLink(destination: { LazyView(destinationView) }, label: {
          textRow
            .wrapperIcon {
              TUIWrapperIcon(icon: .chevronRight20Filled)
                .iconColor(.outline)
            }
            .iconButtons(icons: iconButtons)
            .buttonStyle(.borderless)
            .multilineTextAlignment(.leading)
        })
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(accessibilityID)
      } else {
        textRow
          .buttonStyle(.borderless)
          .accessibilityElement(children: .contain)
          .accessibilityIdentifier(accessibilityID)
      }
    }
  
  // MARK: - Enabled / Disabled
  
  /// This method is used to vaildate the condition, if it's then it will create new view else return the same view
  ///
  /// Example usage:
  ///
  ///     HStack {
  ///         Text("Description")
  ///         .isEnabled(isSelected) { $0.foregroundColor(.green) }
  ///       }
  ///     }
  ///
  /// - Parameters:
  ///   - show: This bool is used to vaildate the condition
  ///   - content: The content can be any SwiftUI view.
  /// - Returns: A closure that returns the content
  ///
  @ViewBuilder
  func isEnabled<Content: View>(_ show: Bool, content: (Self) -> Content) -> some View {
    if show {
      content(self)
    } else {
      self
    }
  }
  
  /// Makes View disabled. Applies `DisabledView` modifier on the current view
  /// - Parameter isDisabled: true / false
  /// - Returns: Modified View
  ///
  func isDisabled(_ isDisabled: Bool) -> some View {
    modifier(DisabledView(isDisabled: isDisabled))
  }
  
  // MARK: - Toolbar Done Button
  
  /// Adds done button in toolbar
  /// - Parameter isDoneClicked: binding that handles when done button is clicked
  /// - Returns: View
  ///
  @ViewBuilder
  func addDoneButtonInToolbar(
    isDoneClicked: Binding<Bool>) -> some View {
      modifier(ToolBarDoneButton(isDoneClicked: isDoneClicked, onClicked: { }))
    }
  
  /// Adds done button in toolbar
  /// - Parameter onClicked: closure that called when done button is clicked
  /// - Returns: View
  ///
  @ViewBuilder
  func addDoneButtonInToolbar(
    onClicked: (() -> Void)? = nil) -> some View {
      modifier(ToolBarDoneButton(isDoneClicked: .constant(false), onClicked: onClicked))
    }
  
  // MARK: - Bottom Mobile Button Block
  
  @ViewBuilder
  /// Adds `TUIMobileButtonBlock` in bottom safe area of the screen.
  /// This function itself makes the keyboard adaptive. No need to handle that explicitly.
  /// - Parameter block: `TUIMobileButtonBlock` that has to be added
  /// - Returns: View with button block added
  func addBottomMobileButtonBlock(
    _ block: TUIMobileButtonBlock,
    @ViewBuilder _ additionalView: () -> some View = { EmptyView() },
    showAdditionalView: Bool = false
  ) -> some View {
    
    let block = BottomMobileButtonBlock(
      block: block,
      additionalView: additionalView(),
      showAdditionalView: showAdditionalView)
    
    modifier(block)
  }
  
  // MARK: - Keyboard
  
  /// Makes the keyboard adaptive to the textfield
  /// - Returns: View
  ///
  @ViewBuilder
  func adaptiveKeyboard(isKeyboardShown: Binding<Bool>) -> some View {
    modifier(AdaptiveKeyboard(isKeyboardShown: isKeyboardShown))
  }
  
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
