//
//  ContentView.swift
//  VKClient
//
//  Created by Ilya on 13.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Image("VK_Full_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(30)
                    HStack {
                        Text("Login:")
                        Spacer()
                        TextField("", text: $login)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 250)
                    }.padding(.horizontal, 20)
                    HStack {
                        Text("Password:")
                        Spacer()
                        SecureField("", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 250)
                    }.padding(.horizontal, 20)
                    Button("Войти") {
                        print("Hello world!")
                    }
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .cornerRadius(5.0)
                    .frame(maxWidth: 300)
                    .padding(.ArrayLiteralElement(arrayLiteral: [.top, .bottom]), 5)
                    .disabled(login.isEmpty || password.isEmpty)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
