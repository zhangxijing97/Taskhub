//
//  TaskItem.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import Foundation

struct TaskItem: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
