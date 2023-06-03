//
//  TaskhubApp.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI
import FirebaseCore

@main
struct TaskhubApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authStore = AuthStore()
    @StateObject private var router = Router()
    
    init() {
      FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    authStore.startAuthStateListener(router: router)
                }
                .onDisappear {
                    authStore.removeAuthStateListener(router: router)
                }
                .environmentObject(authStore)
                .environmentObject(router)
        }
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}
