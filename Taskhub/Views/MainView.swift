//
//  ContentView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // Signed in
            accountView
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            TasksListView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Home", systemImage: "house")
            }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
