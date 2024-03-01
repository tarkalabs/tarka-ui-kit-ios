//
//  TUIPopupView.swift
//
//
//  Created by Gopinath on 12/02/24.
//

import SwiftUI

public struct TUIPopupView<Content: View>: View {
  
  public var onSave: () -> Void = { }
  @Binding var isPresented: Bool
  var title: String
  var content: Content

  public init(
    isPresented: Binding<Bool>,
    title: String,
    @ViewBuilder _ content: @escaping () -> Content) {
      self._isPresented = isPresented
      self.title = title
      self.content = content()
    }
  
  public var body: some View {
    VStack(spacing: Spacing.custom(24)) {
      headerView
      contentView
      bottomBarView
    }
    .background(Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: Spacing.baseHorizontal))
    .padding(.horizontal, Spacing.custom(24))
    .accessibilityIdentifier(Accessibility.root)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - HeaderView
  
  private var headerView: some View {
    VStack(spacing: 0) {
      Text(title)
        .font(.heading5)
        .foregroundStyle(Color.onSurface)
        .frame(height: Spacing.custom(22), alignment: .leading)
        .padding(.horizontal, Spacing.baseHorizontal)
        .accessibilityIdentifier(Accessibility.title)
        .padding(.top, Spacing.custom(20))
        .padding(.bottom, Spacing.custom(22))
        .frame(maxWidth: .infinity)
        .accessibilityIdentifier(Accessibility.title)

      TUIDivider(orientation: .horizontal(hPadding: .zero, vPadding: .zero))
        .color(.surfaceVariantHover)
    }
    .frame(height: 64)
    .frame(maxWidth: .infinity)
    .background(Color.surface)
    .accessibilityElement(children: .contain)
  }
  
  // MARK: - Bottom View
  
  @ViewBuilder
  private var bottomBarView: some View {
    TUIMobileButtonBlock(style: .two(
      left: .init(title: "Cancel".localized) {
        isPresented = false
      },
      right: .init(title: "Save".localized) {
        onSave()
      }))
  }
  
  // MARK: - Content View
  
  private var contentView: some View {
    content
      .background(Color.surface)
      .padding(.horizontal, Spacing.baseHorizontal)
      .accessibilityIdentifier(Accessibility.contentView)
      .accessibilityElement(children: .contain)
  }
}

public extension TUIPopupView {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUIPopupView"
    case title = "Title Label"
    case contentView = "Content View"
  }
  
  func onSave(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onSave = action
    return newView
  }
}

struct TUIPopup_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.gray.opacity(0.3).ignoresSafeArea()
      
      TUIPopupView(
        isPresented: .constant(false), title: "Test") {
        VStack {
          Image(systemName: "star")
            .resizable()
            .frame(width: 100, height: 100)
          Text("Hello")
        }
        .padding(20)
      }
      .padding()
    }
  }
}

