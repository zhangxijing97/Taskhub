//
//  UserFirestore.swift
//  Taskhub
//
//  Created by 张熙景 on 5/30/23.
//

import Foundation

struct UserFirestore: Codable {
    let id: String
    let email: String
    let joined: TimeInterval
}
