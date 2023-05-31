//
//  AuthenticationViewModel.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import Foundation

@MainActor
class AuthenticationViewModel: ObservableObject {

    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isAlertShowing = false
    @Published var isButtonLoading = false

    func loginWithGoogle(authStore: AuthStore) async {
        do {
            try await authStore.loginWithGoogle()
        } catch {
            showAlert(title: "Error", message: error.localizedDescription)
        }
    }

    func loginWithApple(authStore: AuthStore) async {
        authStore.loginWithApple { error in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isAlertShowing = true
    }

    func dismissAlert() {
        alertTitle = ""
        alertMessage = ""
        isAlertShowing = false
    }
}
