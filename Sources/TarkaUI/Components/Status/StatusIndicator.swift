//
//  StatusIndicator.swift
//  
//
//  Created by Gopinath on 29/05/23.
//

import SwiftUI

struct StatusIndicator: View {
    
  @State private var status: ActiveStatus
  
  init(_ status: ActiveStatus) {
    self.status = status
  }
  var body: some View {
    HStack(spacing: Spacing.halfHorizontal) {
      Text(status.text)
        .font(.button8)
        .foregroundColor(.disabledContent)
      
      StatusCircle(.on)
    }
    
  }
}

struct StatusIndicator_Previews: PreviewProvider {
    static var previews: some View {
      StatusIndicator(.on)
    }
}


