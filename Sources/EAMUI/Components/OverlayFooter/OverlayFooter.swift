//
//  OverlayFooter.swift
//
//
//  Created by Arvindh Sukumar on 05/05/23.
//

import SwiftUI

public struct OverlayFooter: View {
  private var actions: [OverlayFooterAction]
  
  public init(@OverlayFooterActionBuilder actions: @escaping () -> [OverlayFooterAction]) {
    self.actions = actions()
  }

  public var body: some View {
    HStack {
      ForEach(actions, id: \.id) { action in
        let index = actions.firstIndex { a in
          a.id == action.id
        } ?? 0
        
        if index > 0 {
          Spacer()
        }
        view(forAction: action)
      }
    }
    .padding()
    .background(Color.surface50)
  }
  
  @ViewBuilder
  private func view(forAction action: OverlayFooterAction) -> some View {
    IconButton(icon: action.icon, style: .ghost, size: .l, action: action.handler)
  }
}

struct OverlayFooter_Previews: PreviewProvider {
  private enum TestAction: OverlayFooterAction {
    var id: String {
      icon.rawValue
    }
    
    var icon: EAMSymbol {
      switch self {
      case .one: return .chevronLeft
      case .two: return .chevronDown
      case .three: return .chevronRight
      }
    }
    
    var handler: () -> Void {
      switch self {
      case .one(let handler), .two(let handler), .three(let handler):
        return handler
      }
    }
    
    case one(() -> Void)
    case two(() -> Void)
    case three(() -> Void)
  }
  
  static var previews: some View {
    Group {
      OverlayFooter {
        TestAction.one {
          
        }
        
        TestAction.two {
          
        }
        
        TestAction.three {
          
        }
      }
      
      OverlayFooter {
        TestAction.one {
          
        }
        
        TestAction.three {
          
        }
        
      }
      
      OverlayFooter {
        TestAction.two {
          
        }
      }
    }
  }
}
