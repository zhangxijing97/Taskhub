//
//  AuthenticationView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices
import GoogleSignInSwift

struct AuthenticationView: View {
    @EnvironmentObject var authStore: AuthStore
    @ObservedObject var viewModel = AuthenticationViewModel()
    
    @State var isSignupViewShown = false
    @State var isLoginViewShown = false
    
    var body: some View {
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color(red: 0, green: 0.3294, blue: 0.3294))
                
                VStack {

                    Spacer()
                    HeaderView(title: "Taskhub", subtitle: "Get things done",  titleColor: Color(red: 1, green: 0.7961, blue: 0.5412))
                    Spacer()
                    
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                            .foregroundColor(.black)
                            .opacity(0.3)
                        
                        VStack(spacing: 0) {

                            // Continue with Apple Button
                            Button {
                                Task {
                                    await viewModel.loginWithApple(authStore: self.authStore)
                                }
                            } label: {
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .foregroundColor(.white)
                                    HStack(spacing: 20) {
                                        Image(systemName: "applelogo")
                                            .font(.system(size: 24))
                                            .frame(width: 22, height: 22)
                                        Text("Continue with Apple")
                                    }
                                    .foregroundColor(Color.black)
                                    .bold()
                                    .padding(.leading, 60)
                                }
                            }
                            .frame(height: 48)
                            .padding(.bottom, 12)
                            
                            // Continue with google Button
                            Button {
                                Task {
                                    await viewModel.loginWithGoogle(authStore: self.authStore)
                                }
                            } label: {
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .foregroundColor(.white)
                                    HStack(spacing: 20) {
                                        Image("google")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                        Text("Continue with Google")
                                    }
                                    .foregroundColor(Color.black)
                                    .bold()
                                    .padding(.leading, 60)
                                }
                            }
                            .frame(height: 48)
                            .padding(.bottom, 12)
                            
                            // Sign up with Email
                            Button {
                                isSignupViewShown = true
                            } label: {
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .foregroundColor(.white)
                                    HStack(spacing: 20) {
                                        Image(systemName: "envelope.fill")
                                            .frame(width: 22, height: 22)
                                        Text("Sign up with Email")
                                    }
                                    .foregroundColor(Color.black)
                                    .bold()
                                    .padding(.leading, 60)
                                }
                            }
                            .frame(height: 48)
                            .padding(.bottom, 12)
                            
                            // Log in
                            Button {
                                isLoginViewShown = true
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .foregroundColor(.black)
                                    HStack {
                                        Text("Log in")
                                    }
                                    .foregroundColor(Color.white)
                                    .bold()
                                }
                            }
                            .frame(height: 48)
                            
                        }
                        .padding(24)
                        .padding(.bottom, 10)
                    }
                    .frame(height: 286)
                    
                }
            }
            .statusBar(hidden: true)
            .ignoresSafeArea(.all)
            .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertShowing) {
                Button(role: .cancel) {
                    viewModel.dismissAlert()
                } label: {
                    Text("Ok")
                }
            } message: {
                Text(viewModel.alertMessage)
            }
            .sheet(isPresented: $isSignupViewShown) {
                SignupView()
            }
            .sheet(isPresented: $isLoginViewShown) {
                LoginView()
            }
            
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
