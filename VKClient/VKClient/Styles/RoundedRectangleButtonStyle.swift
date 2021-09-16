//
//  RoundedRectangleButtonStyle.swift
//  VKClient
//
//  Created by Ilya on 14.09.2021.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(Color.vkBlue.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
