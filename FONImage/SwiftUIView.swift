//
//  SwiftUIView.swift
//  FONImage
//
//  Created by Tahir on 02/08/2021.
//

import SwiftUI

struct DisciptionFiledStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .foregroundColor(.orange)
            .multilineTextAlignment(.center)
    }
}
