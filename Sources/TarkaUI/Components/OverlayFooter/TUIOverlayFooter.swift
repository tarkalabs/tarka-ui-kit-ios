//
//  TUIOverlayFooter.swift
//
//
//  Created by Arvindh Sukumar on 05/05/23.
//

import SwiftUI

/// A view that displays a horizontal list of actions at the bottom of an overlay.
///
/// Use `TUIOverlayFooter` to display a list of actions at the bottom of an overlay. You can add any number of actions to the footer using the `OverlayFooterActionBuilder` closure. Each action is represented by an `TUIOverlayFooterAction` object, which contains an icon and a closure to be executed when the action is tapped.
///
/// Example usage:
///
///     TUIOverlayFooter {
///       TUIOverlayFooterAction(icon: .chevronLeft) {
///         // Handle action
///       }
///       TUIOverlayFooterAction(icon: .chevronDown) {
///         // Handle action
///       }
///       TUIOverlayFooterAction(icon: .chevronRight) {
///         // Handle action
///       }
///     }
///
public struct TUIOverlayFooter: View {
  private var actions: [TUIOverlayFooterAction]
  
  /// Creates a footer with the specified actions.
  ///
  /// - Parameters:
  ///   - actions: The actions to display in the footer.
  ///
  public init(@OverlayFooterActionBuilder actions: @escaping () -> [TUIOverlayFooterAction]) {
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
  private func view(forAction action: TUIOverlayFooterAction) -> some View {
    TUIIconButton(icon: action.icon, action: action.handler)
  }
}

struct OverlayFooter_Previews: PreviewProvider {
  private enum TestAction: TUIOverlayFooterAction {
    var id: String {
      icon.name
    }
    
    var icon: Icon {
      switch self {
      case .one: return Symbol.chevronLeft
      case .two: return Symbol.chevronDown
      case .three: return Symbol.chevronRight
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
      TUIOverlayFooter {
        TestAction.one {
          
        }
        
        TestAction.two {
          
        }
        
        TestAction.three {
          
        }
      }
      
      TUIOverlayFooter {
        TestAction.one {
          
        }
        
        TestAction.three {
          
        }
        
      }
      
      TUIOverlayFooter {
        TestAction.two {
          
        }
      }
    }
  }
}
