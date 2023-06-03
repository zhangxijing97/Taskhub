//
//  ProfileView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ProfileView: View {
    @EnvironmentObject var authStore: AuthStore
    @State private var isSheetPresented = false
    @State private var sheetContent = ""
    
    var body: some View {
        NavigationView {
            List {
                
                // Profile
                Section {
                    NavigationLink(destination: ProfileDetailView()) {
                        HStack(spacing: 16) {
                            if authStore.user?.photoUrl != nil {
                                AsyncImage(url: authStore.user?.photoUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                                        .frame(width: 60, height: 60)
                                }
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                                    .frame(width: 60, height: 60)
                            }
                            VStack(alignment: .leading) {
                                if authStore.user?.name != "" {
                                    Text(authStore.user?.name ?? "Anonymous")
                                        .font(.title2)
                                } else {
                                    Text("Anonymous")
                                        .font(.title2)
                                }
                                Text("Personal Information")
                            }
                        }
                    }
                }
                
                // Info
                Section {
                    NavigationLink(destination: ProfileDetailView()) {
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .foregroundColor(.blue)
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 29, height: 29)
                            
                            Text(authStore.user?.email ?? "Loading")
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    
                    NavigationLink(destination: ProfileDetailView()) {
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .foregroundColor(.green)
                                Text("UID")
                                    .font(.system(size: 13))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .frame(width: 29, height: 29)
                            
                            Text(authStore.user?.id.uppercased() ?? "Loading")
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                }

                // Version
                Section {
                    HStack {
                        Text("Taskhub for iOS Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                }
                
                // Sign out
                Section() {
                    VStack(alignment: .center) {
                        Button {
                            Task {
                                authStore.logout()
                            }
                        } label: {
                            ZStack(alignment: .center) {
                                Text("Sign out")
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileDetailView: View {
    @EnvironmentObject var authStore: AuthStore
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let user = authStore.user {
                    VStack(spacing: 16) {
                        if let photoUrl = user.photoUrl {
                            AsyncImage(url: photoUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } placeholder: {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 120))
                                    .foregroundColor(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                                    .frame(width: 120, height: 120)
                            }
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 120))
                                .foregroundColor(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                                .frame(width: 120, height: 120)
                        }
                        
                        if authStore.user?.name != "" {
                            Text(user.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        } else {
                            Text("Anonymous")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 16)
                    
                    VStack(spacing: 16) {
                        Text(user.email)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("UID: \(user.id.uppercased())")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationBarTitle("Taskhub ID", displayMode: .inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
