//
//  TaskhubApp.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct TaskhubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
