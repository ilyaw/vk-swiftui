//
//  CustomLoader.swift
//  VKClient
//
//  Created by Ilya on 06.11.2021.
//

import SwiftUI

struct CustomLoader: View {
    
    @State var opacity1: Double = 1
    @State var opacity2: Double = 0.7
    @State var opacity3: Double = 0.5
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(Color.blue)
                .opacity(opacity1)
            Circle()
                .foregroundColor(Color.blue)
                .opacity(opacity2)
            Circle()
                .foregroundColor(Color.blue)
                .opacity(opacity3)
        }.onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                opacity1 = 0.5
                opacity2 = 1.0
                opacity3 = 1.0
            }
        }
    }
}

struct CustomLoader_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoader()
    }
}
