//
//  TUIDraggableCard.swift
//
//
//  Created by Arvindh Sukumar on 08/05/23.
//

import SwiftUI

/// A view that represents a draggable card with an icon button, title and toggle.
///
/// The `TUIDraggableCard` view is a container view that displays an icon button  title and toggle.
///  The icon button can be used to trigger a drag gesture to move the card around. The content can be any SwiftUI view.
///
/// Example usage:
///
///     TUIDraggableCard("Description") { }
///       .toggleAction(true) { }
///
/// - Parameters:
///   - title: It's used to display the title of the view
///   - action: It will tigger when user tap and hold for 0.5 seconds
///
/// - Returns: A view that represents a draggable card with an icon button, title and toggle.
///
public struct TUIDraggableCard: View {
  
  private let title: String
  private var action: () -> Void
  
  private var isToggleSelected: Bool
  private var toggleAction: (() -> Void)?
  
  public init(_ title: String, action: @escaping () -> Void) {
    self.title = title
    self.isToggleSelected = false
    self.action = action
  }
  
  public var body: some View {
    HStack(spacing: Spacing.baseHorizontal) {
      leftIconView
      titleView
      toggleSwitchView
    }
    .padding([.vertical, .leading], Spacing.baseVertical)
    .padding(.trailing, Spacing.baseHorizontal)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
  }
  
  private var leftIconView: some View {
    TUIIconButton(icon: .reOrderDotsVertical24Regular) {}
      .size(.size48)
      .disabled(true)
      .contentShape(.dragPreview, contentShape)
      .onDrag({
        action()
        return .init()
      }, preview: previewItemView)
  }
  
  /// We are facing some weird ui issue while onDrag, so we are using clear background to fix the issue
  private func previewItemView() -> some View {
    Color.clear
      .frame(width: 1, height: 1)
  }
  
  private var toggleSwitchView: some View {
    TUIToggleSwitch(isSelected: isToggleSelected) {
      toggleAction?()
    }
  }
  
  private var titleView: some View {
    Text(title)
      .font(.heading6)
      .foregroundStyle(Color.inputText)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  /// We are facing some issue while using on drag, so we using contentShape to create some shape
  private var contentShape: some Shape {
    RoundedRectangle(cornerRadius: Spacing.baseHorizontal - Spacing.baseVertical)
  }
}

public extension TUIDraggableCard {
  
  func toggleAction(_ isSelected: Bool = false, action: @escaping () -> Void) -> Self {
    var newView = self
    newView.isToggleSelected = isSelected
    newView.toggleAction = action
    return newView
  }
}

struct DraggableCard_Previews: PreviewProvider {
  static var previews: some View {
    DraggableCardPreview()
  }
  
  struct DraggableCardPreview: View {
    
    @State private var isSelected = false
    
    var body: some View {
      TUIDraggableCard("TUIDraggableCard") { }
        .toggleAction(isSelected) { isSelected.toggle() }
        .padding()
    }
  }
}
