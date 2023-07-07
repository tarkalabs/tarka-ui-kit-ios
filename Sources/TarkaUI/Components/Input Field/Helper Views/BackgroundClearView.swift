//
//  BackgroundClearView.swift
//  
//
//  Created by Gopinath on 05/07/23.
//

import SwiftUI


/// A SwiftUI view that used to display a half transparent background
/// 
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


struct BackgroundClearView_Previews: PreviewProvider {
    static var previews: some View {
      BackgroundClearView()
    }
}
