//
//  HomeView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authStore: AuthStore
    
    var body: some View {
        TabView {
            TasksListView(userId: authStore.user?.id ?? "")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
