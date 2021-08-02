//
//  ContentView.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI

// Code was extraxted from this: https://blckbirds.com/post/prevent-the-keyboard-from-hiding-swiftui-view/
class KeyboardResponder: ObservableObject {
    
    @Published var currentHeight: CGFloat = 0
    
    var _center: NotificationCenter
    
    init(center: NotificationCenter = .default) {
        _center = center
        _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            withAnimation {
               currentHeight = keyboardSize.height
            }
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        withAnimation {
           currentHeight = 0
        }
    }
}


struct ContentView: View {
    
    @EnvironmentObject var timerInfo:TimerInfo
    
    @State var valeChange =  CGSize(width: 60, height: 0)

    @State var changeView = false
    
    @State var changed = false
    
    var body: some View {
    
        ZStack(alignment: .leading) {
            
            MainView()
                .disabled(timerInfo.showSettings)
            
        
            if timerInfo.showSettings
            {
                Setting()
                        .offset(valeChange)
                    .animation(
                        Animation.easeInOut(duration: 0.4))
            }
          
            
                    
            
            /// End of zoreder
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
