//
//  TextDescription.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI
import Combine

class TextInfo: ObservableObject {
    
    @Published var isTyping = false
    @Published var text = "Pick up from swimming"
}

struct TextDescription: View {
        
    @Environment(\.colorScheme) private var colorScheme
    
    // Local
    @State private var backgroundColor = Color.black
    @State private var backgroundOpacity = 0.0
    
    @EnvironmentObject var texInfo: TextInfo
    @EnvironmentObject var timerInfo: TimerInfo

    
    let placeHolder: String
    
    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .center) {
                TextField("Type somtging", text: $texInfo.text,
                          // Editing the filed
                          onEditingChanged: { changed in
                            
                            
                            if changed
                            {
                                
                                if colorScheme == .dark
                                {
                                    backgroundColor = Color.white
                                    backgroundOpacity = 0.1
                                                            }
                                else if colorScheme == .light
                                {
                                    backgroundColor = Color.black
                                    backgroundOpacity = 0.05
                                }
                                
                                texInfo.isTyping = true
                            }
                            else
                            {
                                backgroundOpacity = 0.0
                                
                                texInfo.isTyping = false
                            }
                           
                          },
                          onCommit:{
                            backgroundOpacity = 0.0
                                                        
                    })
                    .textFieldStyle(DisciptionFiledStyle())
                    .frame(width: geo.size.width - 40, height: geo.size.height, alignment: .center)
                    .background(backgroundColor
                    .opacity(backgroundOpacity))
                    .font(.system(size: 30))
                    
                    .disabled(timerInfo.isActiave)
                    
                    // Currser colour
                    .accentColor(backgroundColor)
            }
            .cornerRadius(6.0, antialiased: true)
            .frame(width: geo.size.width - 80, height: geo.size.height)
            .padding(.horizontal, 40)

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 50)
    }
}
