//
//  AuthStore.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices
import GoogleSignIn

@MainActor
class AuthStore: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    
    @Published var loginState: LoginState = .signedOut
    @Published var user: UserProfile?
    @Published var isAuthLoaded: Bool = false

    private var authListener: AuthStateDidChangeListenerHandle?
    private var onAppleAuthError: ((_ error: Error) -> Void)?
    
    // Sign up with Email
    func signup(email: String, password: String) async throws {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
           guard let userId = result?.user.uid, let userEmail = result?.user.email else {
               return
           }
           self?.insertUserRecord(id: userId, email: userEmail)
       }
    }

    // Log in
    func loginWithEmailAndPassword(email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw error
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
        self.signOutWithGoogle()
        self.loginState = .signedOut
    }
    
    // Continue with Apple
    func loginWithApple(onError: @escaping (_ error: Error) -> Void) {
        self.onAppleAuthError = onError

        let nonce = AuthCryptoService.randomNonceString()
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        request.nonce = AuthCryptoService.sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    nonisolated func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let appleIdToken = appleIdCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }

            guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIdToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: AuthCryptoService.currentNonce)

            Task {
                do {
                    try await self.authenticateWithFirebase(credential: credential)
                } catch {
                    await self.onAppleAuthError!(error)
                }
            }
        }
    }

    nonisolated func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Task {
            await self.onAppleAuthError!(error)
        }
    }

    // Continue with Google
    func loginWithGoogle() async throws {
        let googleSignIn = GIDSignIn.sharedInstance
        var googleUser: GIDGoogleUser

        if googleSignIn.hasPreviousSignIn() {
            do {
                googleUser = try await googleSignIn.restorePreviousSignIn()
            } catch {
                self.signOutWithGoogle()
                throw error
            }
        } else {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            do {
                let result = try await googleSignIn.signIn(withPresenting: rootViewController)
                googleUser = result.user
            } catch {
                throw error
            }
        }

        guard let idToken = googleUser.idToken else { return }
        let accessToken = googleUser.accessToken
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                   accessToken: accessToken.tokenString)

        do {
            try await self.authenticateWithFirebase(credential: credential)
        } catch {
            throw error
        }
    }
    
    private func signOutWithGoogle() {
        GIDSignIn.sharedInstance.signOut()
    }

    private func authenticateWithFirebase(credential: AuthCredential) async throws {
        do {
            try await Auth.auth().signIn(with: credential) { [weak self] result, error in
                if let userId = result?.user.uid, let userEmail = result?.user.email {
                    self?.insertUserRecord(id: userId, email: userEmail)
                }
            }
        } catch {
            throw error
        }
    }
    
    // Insert user record to database
    private func insertUserRecord(id: String, email: String) {
        let newUser = UserFirestore(id: id,
                                    email: email,
                                    joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()

        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }

    func startAuthStateListener(router: Router) {
        self.authListener = Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else {
                self.isAuthLoaded = true
                router.reset()
                return
            }

            let userProfile = UserProfile(id: user.uid,
                                      name: user.displayName ?? "",
                                      email: user.email ?? "",
                                      photoUrl: user.photoURL,
                                      firebaseUser: user)
            self.user = userProfile
            self.loginState = .signedIn
            self.isAuthLoaded = true
            router.reset()
        }
    }

    func removeAuthStateListener(router: Router) {
        guard let authListener = self.authListener else { return }
        Auth.auth().removeStateDidChangeListener(authListener)
    }
}

// MARK: Error enums
extension AuthStore {
    enum AuthErrors: String, Error {
        case emailInUse
        case badEmail
        case badPassword
        case firebaseError
    }

    enum LoginState {
        case signedIn
        case signedOut
    }
}
