//
//  DatePopover.swift
//  
//
//  Created by Gopinath on 05/07/23.
//

import SwiftUI

struct DatePopover: View {
  
  @Binding var date: Date
  @Binding var isShowing: Bool
  
  var body: some View {
    VStack {
      DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
        .datePickerStyle(.graphical)
        .onChange(of: date, perform: { value in
          
          isShowing.toggle()
        })
        .padding(.all, 20)
    }.frame(width: 350, height: 400, alignment: .center)
      .background(.white)
      .cornerRadius(5.0)
  }
}

struct DatePopover_Previews: PreviewProvider {
    static var previews: some View {
      DatePopover(date: Binding.constant(Date()), isShowing: Binding.constant(true))
    }
}
