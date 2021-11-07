//
//  CustomLoader.swift
//  VKClient
//
//  Created by Ilya on 06.11.2021.
//

import SwiftUI

struct CustomLoader: View {
    
    var body: some View {
        HStack {
            DotView()
            DotView(delay: 0.2)
            DotView(delay: 0.4)
        }
    }
}

struct CustomLoader_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoader()
    }
}
