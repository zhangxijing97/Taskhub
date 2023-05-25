//
//  LoginViewViewModel.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import SwiftUI
import Foundation
import FirebaseAuth
import CryptoKit
import AuthenticationServices
import Firebase
import GoogleSignIn

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        // Try log in
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func validate() ->Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email."
            return false
        }
        return true
    }
    
    // Continue with Apple
    @AppStorage("log_status") var log_status = false
    @Published var nonce = ""
    
    // Apple Sign in API
    func authenticate(credential: ASAuthorizationAppleIDCredential) {
        // getting Token
        guard let token  = credential.identityToken else {
            print("error with firebase")
            return
        }
        
        // Token String
        guard let TokenString  = String(data: token, encoding: .utf8) else {
            print("error with fireToken")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: TokenString, rawNonce: nonce)
        
        // Sign in with Firebase
        Auth.auth().signIn(with: firebaseCredential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
              }
              // User is signed in to Firebase with Apple.
            print("log in success")
        }
    }
    
    func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        return String(nonce)
    }
    
    // Continue with Google
    
}
