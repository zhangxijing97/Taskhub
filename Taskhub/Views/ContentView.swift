//
//  ContentView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                if !authStore.isAuthLoaded {
                    ProgressView()
                } else {
                    if authStore.loginState == .signedOut {
                        AuthenticationView()
                } else {
                    HomeView()
                    }
                }
            }
            .animation(.default, value: authStore.loginState)
            .navigationDestination(for: NotAuthenticatedRoutes.self) { $0 }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthStore())
    }
}
