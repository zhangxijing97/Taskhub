//
//  Task.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import Foundation

struct Task: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
