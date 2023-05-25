//
//  ProfileView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading...")
                    ProgressView()
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avator
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.blue)
            .frame(width: 125, height: 125)
            .padding()
        
        // Info: Name, Email, Member since
        VStack(alignment: .leading) {
            HStack {
                Text("Name: ")
                    .bold()
                Text("\(user.firstName) \(user.lastName)")
            }
            HStack {
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            HStack {
                Text("Member since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
        }
        .padding()
        
        // Log Out
        Button("Log Out") {
            viewModel.logout()
        }
        .tint(.red)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
