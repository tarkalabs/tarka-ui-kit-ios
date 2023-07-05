//
//  TUIInputFieldProtocol.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

public protocol TUIInputFieldProtocol where Self: View {
  
  var inputItem: TUIInputFieldItem { get set }
  
  var startItemStyle: TUIInputAdditionalView.Style? { get set }
  var endItemStyle: TUIInputAdditionalView.Style? { get set }
  
  var showHighlightBar: Bool { get set }
  var helperText: TUIHelperText? { get set }
  
}

public extension TUIInputFieldProtocol {
  
  func startItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.startItemStyle = show ? style : nil
    return newView
  }
  
  func endItem(show: Bool = true, withStyle style: TUIInputAdditionalView.Style) -> some TUIInputFieldProtocol {
    var newView = self
    newView.endItemStyle = show ? style : nil
    return newView
  }

  func highlightBar(_ show: Bool = true) -> some TUIInputFieldProtocol {
    var newView = self
    newView.showHighlightBar = show
    return newView
  }
  
  func helperText(show: Bool = true, @ViewBuilder _ helperText: () -> TUIHelperText) -> some TUIInputFieldProtocol {
    var newView = self
    newView.helperText = show ? helperText() : nil
    return newView
  }
}
