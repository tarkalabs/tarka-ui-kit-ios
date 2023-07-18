//
//  TUIInteractiveInputField.swift
//
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

/// This is a SwiftUI View that uses a `TUIInputField` View and acts as Selection Input Field View which sends callback to the caller when the interaction happens.
/// Caller have to manually change the style and text content according to their need.
///
/// It conforms to the same protocol `TUIInputFieldProtocol` that `TUIInputField` conformed and
/// holds all the same properties, variables and public functions that `TUIInputField` View have.
///
public struct TUIInteractiveInputField: TUIInputFieldProtocol {
  
  public var properties = TUIInputFieldOptionalProperties()
  @Binding private var inputItem: TUIInputFieldItem
  private var action: () -> Void
  
  
  /// Creates a`TUIInteractiveInputField` View
  /// - Parameters:
  ///   - inputItem: TUIInputItem's instance that holds the required values to render `TUIInputField` View
  ///   - action: callback when the user interacts with the view
  ///   
  public init(
    inputItem: Binding<TUIInputFieldItem>,
    action: @escaping () -> Void) {
      
      self._inputItem = inputItem
      self.action = action
    }
  
  public var body: some View {
    
    TUIInputField(properties: properties, action: action)
      .environmentObject(inputItem)
      .accessibilityIdentifier(Accessibility.root)
  }
}

extension TUIInteractiveInputField {
  
  enum Accessibility: String, TUIAccessibility {
    case root = "TUISelectionInputField"
  }
}

struct TUISelectionInputField_Previews: PreviewProvider {
  
  static var previews: some View {
    
    @State var item = TUIInputFieldItem(style: .onlyTitle,
                                        title: "Pick value")
    
    TUIInteractiveInputField(inputItem: $item) { item.title = "Value picked" }
      .endItem(withStyle: .icon(.info24Regular))
  }
}
