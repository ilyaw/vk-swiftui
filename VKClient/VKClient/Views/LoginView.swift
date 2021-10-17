//
//  LoginView.swift
//  VKClient
//
//  Created by Ilya on 13.09.2021.
//

import SwiftUI

struct LoginView: View {
    
    @State private var login: String = "admin"
    @State private var password: String = "123456"
    @State private var showIncorrectCredentialsWaring = false
    
    @Binding var isUserAuthorized: Bool
    
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
                    Button(action: {
                        let isPasswordCorrect = verifyLoginData()
                        showIncorrectCredentialsWaring = !isPasswordCorrect
                        withAnimation {
                            isUserAuthorized = isPasswordCorrect
                        }}) { Text("Войти") }
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .cornerRadius(5.0)
                    .frame(maxWidth: 300)
                    .padding(.ArrayLiteralElement(arrayLiteral: [.top, .bottom]), 5)
                    .disabled(login.isEmpty || password.isEmpty)
                }
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }.alert(isPresented: $showIncorrectCredentialsWaring) {
            Alert(
                title: Text("Error"),
                message: Text("Wrong password entered"),
                dismissButton: .default(Text("Got it"), action: clearPassword)
            )
        }
        
    }
    
    private func verifyLoginData() -> Bool {
        return login == "admin" && password == "123456"
    }
    
    private func clearPassword() {
        password = ""
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
