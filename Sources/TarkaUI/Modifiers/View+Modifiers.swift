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
  
  /// Observes the rendered size of a view and updates the provided binding.
  ///
  /// Example:
  /// ```swift
  /// @State private var height: CGFloat = .zero
  ///
  /// Text("Hello")
  ///     .getHeight(for: $height)
  /// ```
  ///
  /// - Parameter size: A binding to receive the current view size.
  /// - Returns: A modified view that updates the size binding.
  func getHeight(_ newValue: Binding<CGFloat>) -> some View {
    onGeometryChange(for: CGFloat.self) { $0.size.height } action: { newValue.wrappedValue = $0 }
  }
  
  /// Observes the rendered size of a view and updates the provided binding.
  ///
  /// Example:
  /// ```swift
  /// @State private var width: CGFloat = .zero
  ///
  /// Text("Hello")
  ///     .getWidth(for: $width)
  /// ```
  ///
  /// - Parameter size: A binding to receive the current view size.
  /// - Returns: A modified view that updates the size binding.
  func getWidth(_ newValue: Binding<CGFloat>) -> some View {
    onGeometryChange(for: CGFloat.self) { $0.size.width } action: { newValue.wrappedValue = $0 }
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
    @TUIIconButtonBuilder
    iconButtons: @escaping (() -> [TUIIconButton]?) = { nil }) -> some View {
      let textRow = TUITextRow(title, style: style)
      
      if isEnabled {
        NavigationLink(destination: destinationView, label: {
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
  func isEnabled<Content: View>(_ show: Bool, @ViewBuilder content: (Self) -> Content) -> some View {
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
  
  
  /// Adds `BackgroundBlurLayer` in background of the view.
  /// It uses opacity that defined in the color asset itself to have transparency.
  /// No modification in the view's opacity.
  ///
  /// - Returns: View with background blur added
  @ViewBuilder
  func addBackgroundBlur(withColor color: Color) -> some View {
    self.background(BackgroundVisualEffectView())
      .background(color)
  }
  
  /// Adds `BackgroundBlurLayer` in background of the view.
  /// It accepts opacity and applies that to the view.
  /// As the color passed here has Opacity as 100,
  /// we are modifying the view's opacity to have transparency.
  ///
  /// - Returns: View with background blur view added
  @ViewBuilder
  func addBackgroundBlur(
    withColor color: Color, opacity: Double) -> some View {
      self.modifier(
        BackgroundBlurView(
        color: color, opacity: opacity))
  }
  
  // MARK: - Keyboard
  
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
