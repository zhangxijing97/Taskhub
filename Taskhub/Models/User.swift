//
//  User.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import Foundation

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let joined: TimeInterval
}
