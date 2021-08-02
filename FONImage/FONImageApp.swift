//
//  FONImageApp.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI

@main
struct FONImageApp: App {
    
    @StateObject var timeInfo = TimerInfo()
    @StateObject var textInfo = TextInfo()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timeInfo)
                .environmentObject(textInfo)
        }
    }
}
