//
//  NavAppearanceModifierSetup.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI

struct NavAppearanceModifierSetup: ViewModifier{
    
    init(backgroundColour: UIColor, forgroundColour: UIColor, tintColour: UIColor?, hideSepratore: Bool){
        
        // Get ref
        let navBarApiraence = UINavigationBarAppearance()
        
        // Navbar background & title text colours
        navBarApiraence.backgroundColor = backgroundColour
        
        navBarApiraence.titleTextAttributes = [.foregroundColor: forgroundColour]
        navBarApiraence.largeTitleTextAttributes = [.foregroundColor: forgroundColour]
        
                
        // Titnt colour
        if let tintColour = tintColour{
            UINavigationBar.appearance().tintColor = tintColour
        }
        
        // Line at the bottom of navbar
        if(hideSepratore){
            navBarApiraence.shadowColor = .clear
        }
        
        // Navbar changees aplyed
        UINavigationBar.appearance().standardAppearance = navBarApiraence
        UINavigationBar.appearance().compactAppearance = navBarApiraence
        UINavigationBar.appearance().scrollEdgeAppearance = navBarApiraence
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func NavagationAppearance(backgroundColour: UIColor, forgroundColour: UIColor, tintColour: UIColor? = nil, hideSepratore: Bool = true) -> some View {
        
        self.modifier(NavAppearanceModifierSetup(backgroundColour: backgroundColour, forgroundColour: forgroundColour, tintColour: tintColour, hideSepratore: hideSepratore))
    }
}
