//
//  File.swift
//  TarkaUI
//
//  Created by Ibrahim Hassan on 13/01/26.
//

import UIKit

extension UITextField {
  
  /// Adds a toolbar with a Done button to the keyboard
  /// - Parameter onDoneClicked: Optional callback executed when Done is tapped
  func addDoneButtonOnKeyboard(onDoneClicked: (() -> Void)? = nil) {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let flexSpace = UIBarButtonItem(
      barButtonSystemItem: .flexibleSpace,
      target: nil,
      action: nil
    )
    
    let doneButton = UIBarButtonItem(
      title: "Done".localized,
      style: .done,
      target: self,
      action: #selector(doneButtonTapped)
    )
    
    // Store callback using objc_setAssociatedObject
    if let callback = onDoneClicked {
      objc_setAssociatedObject(
        self,
        &AssociatedKeys.doneCallback,
        callback as AnyObject,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
    
    toolbar.items = [flexSpace, doneButton]
    self.inputAccessoryView = toolbar
  }
  
  @objc private func doneButtonTapped() {
    self.resignFirstResponder()
    
    // Execute callback if it exists
    if let callback = objc_getAssociatedObject(self, &AssociatedKeys.doneCallback) as? (() -> Void) {
      callback()
    }
  }
  
  private struct AssociatedKeys {
    static var doneCallback = "doneCallback"
  }
}
