//
//  CountDownTimer.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI
import Combine
import UserNotifications

import AVFoundation


class TimerInfo:ObservableObject {
    
    @Published var isActiave = false
    @Published var isplaying = false

    // Notfiy bools
    @Published var playSound = true
    @Published var vibratePhone = true
    
    // Show settinsg
    @Published var showSettings = false

    
    @Published var defaultTime = 0
    @Published var timeRemaining = 0
}

struct CountDownTimer: View {
    
    // Observable
    @EnvironmentObject  var timeInfo: TimerInfo
    @ObservedObject var texInfo = TextInfo()

    @State private var feedback = UINotificationFeedbackGenerator()

    
    // States
    @State private var isEdtingNum = false
    
    @State var selections = [0, 3, 0]
    
    // Constent
    let normalColor: Color = Color.orange
    
    
    init() {
        AskeForNotfcatoon()
    }
    
    
    
    var body: some View {
        
        ZStack {
            VStack
            {
                ZStack {
                    
                    GeometryReader { geo in
                        Text("\(timeString(time: timeInfo.timeRemaining))")
                        
                        .foregroundColor(normalColor)
                        .font(.system(size: geo.size.height))
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .onTapGesture(count: 1) {

                            if !texInfo.isTyping
                            {
                                isEdtingNum = true

                            }
                            else
                            {
                                hideKeyboard()
                            }
                        }
                            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()){ _ in
                            guard timeInfo.isActiave else {return}
                            
                            if(timeInfo.isplaying)
                            {
                                if timeInfo.timeRemaining > 0 {
                                    timeInfo.timeRemaining -= 1
                                    
                                    
                                }
                                else
                                {
                                    if (timeInfo.playSound)
                                    {
                                        let systemSoundID: SystemSoundID = 1027
                                        AudioServicesPlaySystemSound(systemSoundID)
                                    }
                                    
                                    StopTimer()
                                }
                            }
                        }
                    }
                    .disabled(timeInfo.isActiave)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                
                }
                .padding()
                .frame(height: 100.0)
                
            
                GeometryReader { geo in
                    
                    HStack(){
                        Spacer()
                        
                        // Play and pause button
                        Image(timeInfo.isplaying ?"Pause_button" : "Play_button")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .padding(.trailing, geo.size.width * 0.08)
                            .foregroundColor(.orange)
                            .onTapGesture(perform: {
                                
                                if !timeInfo.isActiave
                                {
                                    hideKeyboard()
                                }
                                
                                timeInfo.isActiave = true
                                timeInfo.isplaying.toggle()
                            })
                            .disabled(texInfo.isTyping)
                        
                        
                        //Stop button
                        Text("Stop")
                            .foregroundColor(!timeInfo.isActiave ? .orange.opacity(0.4) : .orange)
                            .font(.system(size: geo.size.height * 0.7))
                            .multilineTextAlignment(.leading)
                            .onTapGesture(perform: {
                                guard timeInfo.isActiave else {return}
                                
                                StopTimer()
                            })
                            .disabled(!timeInfo.isActiave)
                        
                        
                        Spacer()
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 90)
                
                // Sheet view
                .sheet(isPresented: $isEdtingNum, content: {
                    TimerSelect(Selection: $selections)
                 
                })
                .onChange(of: selections, perform: { value in
                            
                    timeInfo.defaultTime = CoverVualeToSTime(hours: selections[0], mints: selections[1], secons: selections[2])
                            
                    timeInfo.timeRemaining = timeInfo.defaultTime
                })
                
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 210, maxHeight: 210)
        }
        .onAppear(perform: {
      
            timeInfo.defaultTime = CoverVualeToSTime(hours: selections[0], mints: selections[1], secons: selections[2])
            
            timeInfo.timeRemaining = timeInfo.defaultTime
        })
    }
    
    
    // Func below  was extracted from this and addapted https://apoorv487.medium.com/create-24-hour-countdown-timer-using-swiftui-fd84a66764e7
    func timeString(time: Int) -> String {
        let hours   = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = (Int(time) % 3600) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func CoverVualeToSTime(hours: Int, mints: Int, secons: Int) ->  Int {
        
        let conHour = hours * 3600
        let conMin = (mints % 3600) * 60
        
        return conHour + conMin + secons
    }
    
    func StopTimer() {
        
        timeInfo.isActiave = false
        timeInfo.isplaying = false;
        
        timeInfo.timeRemaining = timeInfo.defaultTime
        
        
    }
    
    func AskeForNotfcatoon() {
            
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound]) { sucsess, err in
                    
                    if sucsess
                    {
                    }
                    else if let err = err
                    {
                        print(err.localizedDescription)
                    }
                    
                }
    }
}
struct CountDownTimer_Previews: PreviewProvider {
    static var previews: some View {
        CountDownTimer()
    }
}
