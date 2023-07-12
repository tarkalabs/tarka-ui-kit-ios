//
//  TUIButtonBlock.swift
//
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import SwiftUI

/// A view that displays a horizontal row of buttons.
///
/// Use a `TUIButtonBlock` to display a horizontal row of buttons. You can customize the buttons by passing in an array of `TUIButtonBlockAction` objects.
///
/// Example usage:
///
///     TUIButtonBlock {
///         actions...
///     }
///
/// - Note: The `TUIButtonBlock` view takes up the full width of its parent view.
///
///
/// - SeeAlso: `TUIButtonBlockAction`
public struct TUIButtonBlock: View {
  private var actions: [TUIButtonBlockAction] = []
  
  /// Creates a button block with the specified actions.
  ///
  /// - Parameters:
  ///   - actions: The actions to display in the button block.
  ///
  public init(@ButtonBlockActionBuilder actions: @escaping () -> [TUIButtonBlockAction]) {
    self.actions = actions()
  }
    
  public var body: some View {
    HStack(spacing: Spacing.halfHorizontal) {
      ForEach(actions, id: \.id) { action in
        self.button(action: action)
      }
    }
    .padding(.horizontal, Spacing.baseHorizontal)
    .frame(maxWidth: .infinity)
  }
  
  @ViewBuilder
  private func button(action: TUIButtonBlockAction) -> some View {
    Button(action: action.handler) {
      Text(action.title)
        .font(.button6)
        .foregroundColor(.onPrimary)
        .padding(.vertical, Spacing.custom(18))
        .frame(maxWidth: .infinity)
    }
    .contentShape(Rectangle())
    .tint(.primaryTUI)
    .buttonStyle(.borderedProminent)
    .buttonBorderShape(.capsule)
  }
}

struct ButtonBlock_Previews: PreviewProvider {
  private enum TestAction: TUIButtonBlockAction {
    var id: String {
      title
    }
    
    var title: String {
      switch self {
      case .test: return "Test"
      case .test2: return "Test 2"
      }
    }
    
    var leftIcon: FluentIcon? {
      return nil
    }
    
    var rightIcon: FluentIcon? {
      return nil
    }
    
    var handler: () -> Void {
      switch self {
      case .test(let handler), .test2(let handler):
        return handler
      }
    }
    
    case test(() -> Void)
    case test2(() -> Void)
  }

  static var previews: some View {
    TUIButtonBlock {
      TestAction.test {
        print("test")
      }
        
      TestAction.test2 {
        print("test 2")
      }
    }
  }
}
