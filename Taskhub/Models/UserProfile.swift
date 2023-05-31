//
//  UserProfile.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import FirebaseAuth
import Foundation

struct UserProfile: Identifiable {
    let id: String
    let name: String
    let email: String
    let photoUrl: URL?
    let firebaseUser: User
}
