//
//  CircleShadow.swift
//  VKClient
//
//  Created by Ilya on 21.09.2021.
//

import SwiftUI

struct CircleView: ViewModifier {
    let shadowColor: Color = Color.black
    let shadowRadius: CGFloat = 3.5
    
    func body(content: Content) -> some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .shadow(color: shadowColor, radius: shadowRadius)
            content.clipShape(Circle())
        }
        
    }
}
