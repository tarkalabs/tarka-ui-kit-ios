//
//  TUITip.swift
//
//
//  Created by Navin Kumar on 12/09/24.
//

import SwiftUI
import TipKit


/// Small helper protocol for a tip that is available below iOS 17
/// so that we can pass tips around and have members storing tips,
/// as stored properties can't be marked with `@available`.
@available(iOS, obsoleted: 17, message: "It'll be removed once we only support iOS 17+")
public protocol TUITip {
  
  @available(iOS 17, *)
  var tip: AnyTip { get }
  
}

@available(iOS 17, *)
public extension Tip where Self: TUITip {
  
  var tip: AnyTip { AnyTip(self) }
  
}

/// A SwiftUI modifier that conditionally applies a TipKit tip for iOS 17+.
/// Optimized to prevent re-render issues by encapsulating tip logic in the modifier.
/// The tip is only displayed if `tuiTip` is available and running on iOS 17+.
///
/// Example usage:
/// ```swift
/// let myTip = MyTip() // Conforms to TUITip
/// someView.modifier(TipViewModifier(myTip, arrowEdge: .top))
/// ```
struct TipViewModifier: ViewModifier {
  
  let tuiTip: TUITip?
  let arrowEdge: Edge
  
  init(_ tuiTip: TUITip?, arrowEdge: Edge) {
    self.tuiTip = tuiTip
    self.arrowEdge = arrowEdge
  }
  
  func body(content: Content) -> some View {
    mainView(content)
  }
  
  @ViewBuilder
  func mainView(_ content: Content) -> some View {
    if #available(iOS 17, *), let tip = tuiTip?.tip {
      content.popoverTip(tip, arrowEdge: arrowEdge)
    } else {
      content
    }
  }
}

public extension View {
  /// A helper for applying the `popupTip` modifier for iOS versions below 17.
  ///
  /// - Parameters:
  ///   - tip: The optional `TUITip` instance to use.
  ///   - arrowEdge: The edge where the arrow of the tip should point.
  /// - Returns: A view with the `popupTip` modifier applied from iOS  17.
  ///
  /// Example usage:
  /// ```swift
  /// let myTip = MyTip() // Example tip
  /// someView.popupTip(myTip, arrowEdge: .top)
  /// ```
  @available(iOS, obsoleted: 17, message: "Can be removed once we only support iOS 17+")
  @ViewBuilder func popupTip(_ tip: TUITip?, arrowEdge: Edge = .top) -> some View {
    modifier(TipViewModifier(tip, arrowEdge: arrowEdge))
  }
}
