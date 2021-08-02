//
//  Setting.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI


struct Setting: View {
        
    @EnvironmentObject var timerInfo: TimerInfo
    @ObservedObject var textInfo = TextInfo()
    
        
    var body: some View {
        
        GeometryReader { geo in

            VStack(alignment: .leading) {
        
                VStack() {
                    VStack(alignment: .leading) {

                        HStack{
                            
                            Text("Setting")
                                .foregroundColor(.orange)
                                .font(.title)
                                .padding(.bottom, 40)
                                .padding(.top, 12)
                            
                            Spacer()
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 36))
                                .foregroundColor(.orange)
                                .padding(.bottom, 30)
                                .onTapGesture {
                                    
                                    timerInfo.showSettings = false
                                }
                        }
                        .frame(width: geo.size.width / 1.6, height: geo.size.height / 5, alignment: .leading)

                        
                        Text(textInfo.text)
                            .foregroundColor(.orange)
                            .font(.system(size: geo.size.width / 12))
                            .padding(.bottom, 10)

                        
                        Text("\(timeString(time: timerInfo.timeRemaining))")
                            .foregroundColor(.orange)
                            .font(.system(size: geo.size.width / 8))
                    }
                    .padding(.leading, 25)
                    .padding(.bottom, 10)

                }
                .frame(width: geo.size.width, height: geo.size.height / 2.5, alignment: .leading)
                .background(Color.gray.opacity(0.1))

                ScrollView() {
                
                VStack {
                    
                    Spacer(minLength: 30)
                    
                    Text("Notify")
                        .font(.title)
                        .foregroundColor(.orange)
                        .padding(.bottom)
                    
                    
                    HStack () {
                        Spacer()

                        Toggle("Notify", isOn: $timerInfo.playSound).labelsHidden()
                        

                        Spacer()

                        Text("\(String(timerInfo.playSound))")
                            .font(.system(size: 35))
                            .foregroundColor(.orange)
                        Spacer()
                    }
                    
                    Spacer(minLength: 50)

                }
                .frame(minWidth: 0, maxWidth: geo.size.width / 1.2, minHeight: 0, maxHeight: geo.size.height)

                
            }
                
        }
        .frame(minWidth: 0, maxWidth: geo.size.width, minHeight: 0, maxHeight: geo.size.height)

    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .background(Color.white)
        .ignoresSafeArea()

    }
    
    
    // Func below  was extracted from this and addapted https://apoorv487.medium.com/create-24-hour-countdown-timer-using-swiftui-fd84a66764e7
    func timeString(time: Int) -> String {
        let hours   = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = (Int(time) % 3600) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

extension View {
    
    
}
struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
