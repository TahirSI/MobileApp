//
//  MainView.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI

struct MainView: View {
    
    @State private var discriptionText = "No mrore work"
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
        
    @EnvironmentObject var timerInfo: TimerInfo
    @EnvironmentObject var textInfo: TextInfo
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                // Background colour
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack(){
                    
                    Spacer(minLength: 10)
                    
                    ImageWindow()
                        .padding(.bottom, 10)
                 
                    
                    CountDownTimer()
                    
                    Spacer()

                    TextDescription(placeHolder: "What the image")
                        .disabled(timerInfo.isActiave)

      
                    Spacer(minLength: 40)
                 
                }
            }
            .offset(y: -keyboardResponder.currentHeight*0.2)
            .animation(
                Animation.easeInOut(duration: 0.4))
            .navigationBarTitle(
                Text(discriptionText), displayMode: .inline
                )
            .navigationBarItems(
                trailing:
                    (Button(action: {
                        withAnimation {
                            timerInfo.showSettings.toggle()
                        }
                    }){
                    
                    Image("Side_Pnale")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.orange)
                    .padding(.trailing, 18)
                                        }
            
                    )
                    .onTapGesture {
                        timerInfo.showSettings = true
            
                    })
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarBackButtonHidden(true)
        }
        .NavagationAppearance(backgroundColour: .systemBackground, forgroundColour: .orange)
    }
}

// Hide keyboard
// Code from:https://designcode.io/swiftui-handbook-hide-keyboard
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
