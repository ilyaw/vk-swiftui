//
//  DotView.swift
//  VKClient
//
//  Created by Ilya on 07.11.2021.
//

import SwiftUI

struct DotView: View {
    
    @State var delay: Double = 0
    @State private var scale: CGFloat = 0.5
    
    var body: some View {
        Circle()
            .frame(width: 70, height: 70)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.6).repeatForever().delay(delay)) {
                    self.scale = 1
                }
            }
    }
}

struct DotView_Previews: PreviewProvider {
    static var previews: some View {
        DotView()
    }
}
