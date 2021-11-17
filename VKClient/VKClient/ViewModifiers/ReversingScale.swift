//
//  ReversingScale.swift
//  VKClient
//
//  Created by Ilya on 06.11.2021.
//

import SwiftUI

struct ReversingScale: AnimatableModifier {
    var value: CGFloat
    
    private var target: CGFloat
    private var onEnded: () -> ()
    
    init(to value: CGFloat, onEnded: @escaping () -> () = {}) {
        self.target = value
        self.value = value
        self.onEnded = onEnded // << callback
    }
    
    var animatableData: CGFloat {
        get { value }
        set { value = newValue
            // newValue here is interpolating by engine, so changing
            // from previous to initially set, so when they got equal
            // animation ended
            if newValue == target {
                onEnded()
            }
        }
    }
    
    func body(content: Content) -> some View {
        content.scaleEffect(value)
    }
}
