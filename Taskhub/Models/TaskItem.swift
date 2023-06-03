//
//  TaskItem.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import Foundation

struct TaskItem: Codable, Identifiable, Equatable {
    let id: String
    var title: String
    var dueDate: TimeInterval
    var createdDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
    
    mutating func pushDueOneDay() {
        dueDate = dueDate + 24 * 60 * 60
    }
}
