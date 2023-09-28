//
//  BackgroundColorView.swift
//
//
//  Created by Gopinath on 05/07/23.
//

import SwiftUI

@available(iOS, deprecated: 16.4, obsoleted: 16.4, message: "We no longer need this class as we use `.presentationBackground` from iOS 16.4")
/// A SwiftUI View that used to display a half transparent background
///
struct BackgroundColorView: UIViewRepresentable {
  
  var color: Color
  
  init(color: Color) {
    self.color = color
  }

  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .init(color)
    }
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}

struct BackgroundColorView_Previews: PreviewProvider {
  static var previews: some View {
    BackgroundColorView(color: .surface)
  }
}
