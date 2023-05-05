//
//  ButtonBlock.swift
//
//
//  Created by Arvindh Sukumar on 02/05/23.
//

import Foundation
import SwiftUI

public struct ButtonBlock: View {
  private var actions: [ButtonBlockAction] = []
  
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
