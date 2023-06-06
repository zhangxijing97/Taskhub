//
//  SignupView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var authStore: AuthStore
    @ObservedObject var viewModel = SignupViewViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .statusBar(hidden: true)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                SignupTransitionText()
                
                VStack(spacing: 48) {
                    CustomInput(text: $viewModel.email, placeholder: "Email",   isPassword: false)
                    CustomInput(text: $viewModel.password, placeholder: "Password", isPassword: true)
                    CustomInput(text: $viewModel.passwordConfirmation, placeholder: "Confirm your password", isPassword: true)
                }
                
                CustomButton(title: "Sign up", isDisabled: viewModel.isButtonDisabled, isLoading: viewModel.isButtonLoading) {
                    Task {
                        await viewModel.signup(authStore: self.authStore)
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

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
