//
//  TasksListViewModel.swift
//  Taskhub
//
//  Created by 张熙景 on 5/30/23.
//

import Foundation
import FirebaseFirestore

class TasksListViewModel: ObservableObject {
    @Published var showingNewTaskView = false
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    // Get all completed Tasks
    func filterCompletedTasks(tasks: [TaskItem]) -> [TaskItem] {
        return tasks.filter { $0.isDone }
    }

    // Get all uncompleted Tasks
    func filterUncompletedTasks(tasks: [TaskItem]) -> [TaskItem] {
        return tasks.filter { !$0.isDone }
    }
    
    // Sorted tasks By dueDate
    func sortTasksByDueDate(tasks: [TaskItem]) -> [TaskItem] {
        return tasks.sorted { $0.dueDate < $1.dueDate }
    }
    
    // Sorted tasks By dueDate
    func sortTasksByCreatedDate(tasks: [TaskItem]) -> [TaskItem] {
        return tasks.sorted { $0.createdDate < $1.createdDate }
    }
    
    // Delete task from TasksLsist
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("tasks")
            .document(id)
            .delete()
    }
}
