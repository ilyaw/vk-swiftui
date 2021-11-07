//
//  StartView.swift
//  VKClient
//
//  Created by Ilya on 07.11.2021.
//

import SwiftUI

struct StartView: View {
    
    @State var animated = false
    @State var endSpash = false
    
    var body: some View {
        
        ZStack {
            ContentView()
            ZStack {
                Image("VK_Compact_Logo")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animated ? .fill : .fit)
                    .frame(width: animated ? nil : 100, height: animated ? nil : 100)
                    .offset(y: -5)
                    .ignoresSafeArea(.all, edges: .all)
                    .scaleEffect(animated ? 25 : 1)
                    .frame(width: UIScreen.main.bounds.width)
            }
            .background(Color.white)
            .onAppear(perform: animateSpash)
            .ignoresSafeArea(.all, edges: .all)
            .opacity(endSpash ? 0 : 1)
        }
    }
    
    private func animateSpash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            withAnimation(.linear(duration: 1.0)) {
                animated.toggle()
            }
            
            withAnimation(.linear(duration: 0.5)) {
                endSpash.toggle()
            }
        }
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
