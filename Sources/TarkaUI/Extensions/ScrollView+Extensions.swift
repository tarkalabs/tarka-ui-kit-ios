//
//  File.swift
//  
//
//  Created by Gopinath on 14/08/23.
//

import SwiftUI

public extension ScrollView {
  
  @ViewBuilder
  func addBottomMobileButtonBlock(_ block: TUIMobileButtonBlock) -> some View {
    self.addButtonBlockInBottomSafeArea(block)
  }
}
