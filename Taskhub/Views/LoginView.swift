//
//  LoginView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var authStore: AuthStore
    @ObservedObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
            
            VStack {
                VStack(spacing: 25) {
                    CustomInput(text: $viewModel.email, placeholder: "Email", isPassword: false)
                    CustomInput(text: $viewModel.password, placeholder: "Password", isPassword: true)
                    
                    forgotPassword()
                    
                    CustomButton(title: "SIGN IN", isDisabled: viewModel.isButtonDisabled, isLoading: viewModel.isButtonLoading) {
                        Task {
                            await viewModel.loginWithEmailAndPassword(authStore: authStore)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}

struct forgotPassword: View {
    var body: some View {
        HStack {
            Spacer()

            Button {
                print("I forgot my password :(")
            } label: {
                Text("Forgot your password?")
                    .padding(.vertical)
                    .foregroundColor(.white)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
