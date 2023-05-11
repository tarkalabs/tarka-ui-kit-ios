//
//  ButtonBlock.swift
//
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import Foundation
import SwiftUI

/// A view that displays a horizontal row of buttons.
///
/// Use a `ButtonBlock` to display a horizontal row of buttons. You can customize the buttons by passing in an array of `ButtonBlockAction` objects.
///
/// Example usage:
///
///     ButtonBlock {
///         actions...
///     }
///
/// - Note: The `ButtonBlock` view takes up the full width of its parent view.
///
///
/// - SeeAlso: `ButtonBlockAction`
public struct ButtonBlock: View {
  private var actions: [ButtonBlockAction] = []
  
  /// Creates a button block with the specified actions.
  ///
  /// - Parameters:
  ///   - actions: The actions to display in the button block.
  ///
  public init(@ButtonBlockActionBuilder actions: @escaping () -> [ButtonBlockAction]) {
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
  private func button(action: ButtonBlockAction) -> some View {
    Button(action: action.handler) {
      Text(action.title)
        .font(.button6)
        .foregroundColor(.onPrimary)
        .padding(.vertical, Spacing.custom(18))
        .frame(maxWidth: .infinity)
    }
    .contentShape(Rectangle())
    .tint(.primaryEAM)
    .buttonStyle(.borderedProminent)
    .buttonBorderShape(.capsule)
  }
}

struct ButtonBlock_Previews: PreviewProvider {
  private enum TestAction: ButtonBlockAction {
    var id: String {
      title
    }
    
    var title: String {
      switch self {
      case .test: return "Test"
      case .test2: return "Test 2"
      }
    }
    
    var leftIcon: EAMSymbol? {
      return nil
    }
    
    var rightIcon: EAMSymbol? {
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
    ButtonBlock {
      TestAction.test {
        print("test")
      }
        
      TestAction.test2 {
        print("test 2")
      }
    }
  }
}
