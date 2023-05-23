//
//  TaskhubApp.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import FirebaseCore
import SwiftUI

@main
struct TaskhubApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
