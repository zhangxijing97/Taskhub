//
//  LoginView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @AppStorage("log_status") var log_status = false
    @State var isRegisterViewShown = false
//    @State var isClockViewShown = false
    
    var body: some View {
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color(red: 0, green: 0.3294, blue: 0.3294))
                
                VStack {
                    
                    //                    ZStack {
                    Spacer()
                    HeaderView(title: "Taskhub", subtitle: "Get things done",  titleColor: Color(red: 1, green: 0.7961, blue: 0.5412))
                    Spacer()
                    //                    }
                    
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                            .foregroundColor(.black)
                            .opacity(0.5)
                        
                        VStack(spacing: 0) {
                            
                            // Continue with Apple Button
//                            SignInWithAppleButton { (request) in
//                                viewModel.nonce = viewModel.randomNonceString()
//                                request.requestedScopes = [.email, .fullName]
//                                request.nonce = viewModel.sha256(viewModel.nonce)
//                            } onCompletion: { (result) in
//                                // Error or success
//                                switch result {
//                                case.success(let user):
//                                    print("Success")
//                                    // Do Login With Firebase
//                                    guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
//                                        print("error with firebase")
//                                        return
//                                    }
//                                    viewModel.authenticate(credential: credential)
//                                case.failure(let error):
//                                    print(error.localizedDescription)
//                                }
//                            }
//                            .signInWithAppleButtonStyle(.white)
                            
                            // Continue with Apple Button
                            
//                                                        Button {
//                                                        } label: {
//                                                            ZStack {
//                                                                RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                                                    .foregroundColor(.white)
//                                                                HStack {
//                                                                    Image(systemName: "applelogo")
//                                                                    Text("Sign in with Apple")
//                                                                        .font(.system(size: 19, weight: .medium))
//                                                                }
//                                                                .foregroundColor(Color.black)
//                                                            }
//                                                        }
//                                                        .frame(height: 48)
//                                                        .padding(.bottom, 12)

                            
                            // Continue with Apple Button
                            Button {
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
                            .overlay {
                                SignInWithAppleButton { (request) in
                                    viewModel.nonce = viewModel.randomNonceString()
                                    request.requestedScopes = [.email, .fullName]
                                    request.nonce = viewModel.sha256(viewModel.nonce)
                                } onCompletion: { (result) in
                                    // Error or success
                                    switch result {
                                    case.success(let user):
                                        print("Success")
                                        // Do Login With Firebase
                                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                            print("error with firebase")
                                            return
                                        }
                                        viewModel.authenticate(credential: credential)
                                    case.failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                .signInWithAppleButtonStyle(.white)
                                .frame(height: 20)
                                .blendMode(.overlay)
                            }
                            .clipped()
                            .padding(.bottom, 12)
                            
                            // Continue with Google Button
                            Button {
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
                            .overlay {
                                SignInWithAppleButton { (request) in
                                    viewModel.nonce = viewModel.randomNonceString()
                                    request.requestedScopes = [.email, .fullName]
                                    request.nonce = viewModel.sha256(viewModel.nonce)
                                } onCompletion: { (result) in
                                    // Error or success
                                    switch result {
                                    case.success(let user):
                                        print("Success")
                                        // Do Login With Firebase
                                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                            print("error with firebase")
                                            return
                                        }
                                        viewModel.authenticate(credential: credential)
                                    case.failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                .signInWithAppleButtonStyle(.white)
                                .frame(height: 48)
                                .blendMode(.overlay)
                            }
                            .clipped()
                            .padding(.bottom, 12)
                            
                            // Sign up with Email
                            Button {
                                isRegisterViewShown = true
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
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .foregroundColor(.black)
                                    //                                        .foregroundColor(Color(red: 0.1725, green: 0.1725, blue: 0.1725))
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
        }
        .sheet(isPresented: $isRegisterViewShown) {
            RegisterView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
