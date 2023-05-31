//
//  ProfileView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authStore: AuthStore
    @State private var isSheetPresented = false
    @State private var sheetContent = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .ignoresSafeArea()
            
            VStack {
            Header(sheetContent: $sheetContent,
                   isSheetPresented: $isSheetPresented,
                   profileImage: authStore.user?.photoUrl)
                Spacer()
                
                Text(authStore.user?.email ?? "don't have email")
                    .foregroundColor(.white)
//                Text(authStore.user?.id.uuidString ?? "")
                Text(authStore.user?.id ?? "")
                    .foregroundColor(.white)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                Button {
                    Task {
                        authStore.logout()
                    }
                } label: {
                    Text("Sign out")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
