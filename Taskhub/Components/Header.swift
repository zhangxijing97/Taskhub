//
//  Header.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct Header: View {
    @Binding var sheetContent: String
    @Binding var isSheetPresented: Bool
    let profileImage: URL?
    
    var body: some View {
        HStack {
            Button {
                sheetContent = "friends"
                isSheetPresented = true
            } label: {
                Image(systemName: "person.2.fill")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 42, height: 42)
                  .foregroundColor(.white)
            }

            Spacer()

            Text("Moody")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()

            Spacer()

            Button {
                sheetContent = "profile"
                isSheetPresented = true
            } label: {
                if profileImage != nil {
                    AsyncImage(url: profileImage) { image in
                        image
                          .resizable()
                          .scaledToFit()
                          .frame(width: 54, height: 54)
                          .clipShape(Circle())
                    } placeholder: {
                        Text("Loading...")
                    }
                } else {
                    Circle()
                        .foregroundColor(.gray)
                        .frame(width: 54, height: 54)
                        .overlay {
                            Image(systemName: "person.fill")
                                .font(.title)
                                .foregroundColor(.white.opacity(0.5))
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
          .environmentObject(AuthStore())
    }
}
