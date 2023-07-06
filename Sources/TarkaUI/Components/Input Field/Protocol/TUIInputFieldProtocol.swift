//
//  TUIInputFieldProtocol.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

public protocol TUIInputFieldProtocol where Self: View {
  
  var startItemStyle: TUIInputAdditionalView.Style? { get set }
  var endItemStyle: TUIInputAdditionalView.Style? { get set }
  
  var highlightBar: Color? { get set }
  var helperText: TUIHelperText? { get set }
}
