//
//  TimerSelect.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI

struct TimerSelect: View {
        
    @Binding var Selection: [Int]
    @State private var selectionAmount = [24, 60, 60,]

    var body: some View {
        GeometryReader { geo in
            
            VStack{
                
                VStack {
                    Text(CombinValues(hours: Selection[0], mints: Selection[1], secs: Selection[2]))
                        .foregroundColor(.orange)
                        .font(.system(size: geo.size.width / 7))
                }
                .frame(width: geo.size.width, height: geo.size.height / 4)
                
                HStack {
                
                    ForEach(0..<3) { count in
                        Picker("\(selectionAmount[count])", selection: $Selection[count]) {
                            ForEach(0..<selectionAmount[count]+1) { pic in
                                Text("\(pic)").tag(pic)
                                    .foregroundColor(.orange)
                            }
                            
                        }

                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        
                        
                        
                    }
                    .clipped()

                }
                .padding(.horizontal, 10)
                .frame(width: geo.size.width, height: geo.size.height / 2)
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }

    
    func CombinValues(hours: Int, mints: Int, secs: Int) -> String
    {
        return String(format:"%02i:%02i:%02i", hours, mints, secs)
    }
}

//struct TimerSelect_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerSelect()
//    }
//}
