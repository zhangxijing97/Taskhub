//
//  LoginView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                Spacer()
                HeaderView(title: "Taskhub", subtitle: "Get things done", angle: 15, background: .pink)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 36)
                        .foregroundColor(.black)
                    
                    VStack {
                        
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.white)
                                Text("test")
                                    .foregroundColor(Color.white)
                                    .bold()
                            }
                        }
                        
                    }
                    .padding(24)
                }
                
                // Login Form
//                Form {
//                    if !viewModel.errorMessage.isEmpty {
//                        Text(viewModel.errorMessage)
//                            .foregroundColor(Color.red)
//                    }
//
//                    TextField("Email Address", text: $viewModel.email)
//                        .textFieldStyle(DefaultTextFieldStyle())
//                        .autocapitalization(.none)
//                        .autocorrectionDisabled()
//
//                    SecureField("Password", text: $viewModel.password)
//                        .textFieldStyle(DefaultTextFieldStyle())
//
//                    THButton(
//                        title: "Log In",
//                        background: .blue) {
//                        // Attempt log in
//                            viewModel.login()
//                    }
//                        .padding()
//                }
//                .offset(y: -50)
                
                // Create Account
//                VStack {
//                    Text("New around here?")
//                    NavigationLink("Create an Account", destination: RegisterView())
//                }
//                .padding(.bottom, 30)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
