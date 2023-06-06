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
                .statusBar(hidden: true)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                LoginTransitionText()
                
                VStack(spacing: 48) {
                    CustomInput(text: $viewModel.email, placeholder: "Email", isPassword: false)
                    CustomInput(text: $viewModel.password, placeholder: "Password", isPassword: true)
                }
                
                CustomButton(title: "Log in", isDisabled: viewModel.isButtonDisabled, isLoading: viewModel.isButtonLoading) {
                    Task {
                        await viewModel.loginWithEmailAndPassword(authStore: authStore)
                    }
                }
                .padding(.top, 48)
            }
            .padding(24)
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertShowing) {
            Button {
                viewModel.dismissAlert()
            } label: {
                Text("Ok")
            }
        } message: {
            Text(viewModel.alertMessage)
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
            
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
