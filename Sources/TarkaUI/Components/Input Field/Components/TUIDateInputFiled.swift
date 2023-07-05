//
//  TUIDateInputField.swift
//  
//
//  Created by Gopinath on 04/07/23.
//

import SwiftUI

public struct TUIDateInputField: TUIInputFieldProtocol {
  
  @ObservedObject public var inputItem: TUIInputFieldItem {
    didSet {
      inputFieldItem = TUIInputField(inputItem: inputItem)
    }
  }
  
  public var startItemStyle: TUIInputAdditionalView.Style? {
    didSet {
      inputFieldItem.startItemStyle = startItemStyle
    }
  }
  public var endItemStyle: TUIInputAdditionalView.Style? {
    didSet {
      inputFieldItem.endItemStyle = endItemStyle
    }
  }
  
  public var showHighlightBar = false {
    didSet {
      inputFieldItem.showHighlightBar = showHighlightBar
    }
  }
  public var helperText: TUIHelperText? {
    didSet {
      inputFieldItem.helperText = helperText
    }
  }
  
  @State internal var isSheetPresented = false
  @State internal var date = Date()
  
  var inputFieldItem: TUIInputField
  
  public init(inputItem: TUIInputFieldItem) {
    self.inputItem = inputItem
    inputFieldItem = TUIInputField(inputItem: inputItem)
  }
  
  public var body: some View {
    
    Button(action: {
      self.isSheetPresented = true
    }) {
      inputFieldItem
        .onChange(of: date) { newValue in
          self.inputItem.style = .titleWithValue
          self.inputItem.value = newValue.description
        }
      // TODO: @Gopi, need to decide about the presentation
//        .popover(isPresented: $isSheetPresented) {
//        .fullScreenCover(
//          isPresented: $isSheetPresented) {
        .sheet(
        isPresented: $isSheetPresented,
        content: {
          DatePopover(date: $date, isShowing: $isSheetPresented)
            .background(BackgroundClearView())
            .presentationDetents([.fraction(0.9)])
        })
    }
  }
}


struct DatePopover: View {

@Binding var date: Date
@Binding var isShowing: Bool

    var body: some View {
        VStack {
            DatePicker("", selection: $date, displayedComponents: [.date])
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

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
          view.superview?.superview?.backgroundColor = .clear.withAlphaComponent(0.5)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
