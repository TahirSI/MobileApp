//
//  ImageWindow.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI

struct ImageWindow: View {
            
    @EnvironmentObject var timeInfo: TimerInfo

    @State var image: Image? = Image("Image")

    @State private var acatuonSheet = false
    @State private var imagePicker = false
    @State private var cameraPiker = false
    
    var body: some View {
        
        
        GeometryReader { geo in
                
                // Front slot & image
                ZStack{
                    // Border
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color.orange)
                        .frame(width: geo.size.width - 90, height: geo.size.width - 170)
                    
                    image!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width - 110, height: geo.size.width - 195)
                        .clipped()

                        .onTapGesture {
                
                            if !timeInfo.isActiave
                            {
                                self.acatuonSheet = true
                            }
                        }
                        .fullScreenCover(isPresented: $imagePicker) {
                            ImagePicker(sourceType: self.cameraPiker ? .camera : .photoLibrary, image: $image, isPresented: self.$imagePicker)
                                .frame(width: .infinity, height: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .ignoresSafeArea()
                            
                        }
                }
                .actionSheet(isPresented: $acatuonSheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Choose mode"), message: Text("Please select a opstion"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        self.imagePicker = true
                        self.cameraPiker = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.imagePicker = true
                        self.cameraPiker = false
                    }), ActionSheet.Button.cancel()])
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .center)
    }
}

// Code for image picker from from: https://betterprogramming.pub/how-to-pick-an-image-from-camera-or-photo-library-in-swiftui-a596a0a2ece
struct ImageWindow_Previews: PreviewProvider {
    static var previews: some View {
        ImageWindow()
    }
}
