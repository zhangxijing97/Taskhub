//
//  TasksListViewModel.swift
//  Taskhub
//
//  Created by 张熙景 on 5/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TasksListViewModel: ObservableObject {
    @Published var showingNewTaskView = false
    @Published var userId: String
    
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
    
    // Sorted tasks By dueDate late first
    func sortTasksByDueDateLateFirst(tasks: [TaskItem]) -> [TaskItem] {
        return tasks.sorted { $0.dueDate > $1.dueDate }
    }
    
    // Sorted tasks By dueDate early first
    func sortTasksByDueDateEarlyFirst(tasks: [TaskItem]) -> [TaskItem] {
        return tasks.sorted { $0.dueDate < $1.dueDate }
    }
    
    // Sorted tasks By createDate late first
    func sortTasksByCreatedDateLateFirst(tasks: [TaskItem]) -> [TaskItem] {
        return tasks.sorted { $0.createdDate > $1.createdDate }
    }
    
    // Sorted tasks By createDate early first
    func sortTasksByCreatedDateEarlyFirst(tasks: [TaskItem]) -> [TaskItem] {
        return tasks.sorted { $0.createdDate < $1.createdDate }
    }
    
    // Get DueDates
    func getDueDates(tasks: [TaskItem]) -> [String] {
        var dueDates: [String] = []
        for task in tasks {
            let formattedDueDate = Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .omitted)
            if !dueDates.contains(formattedDueDate) {
                dueDates.append(formattedDueDate)
            }
        }
        return dueDates
    }
    
    // Get tasks for DueDate
    func tasksForDueDate(tasks: [TaskItem], dueDate: String) -> [TaskItem] {
        let filteredTasks = tasks.filter { task in
            let formattedDueDate = Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .omitted)
            return formattedDueDate == dueDate
        }
        return filteredTasks
    }
    
    // Get CreatedDates
    func getCreatedDates(tasks: [TaskItem]) -> [String] {
        var createdDates: [String] = []
        for task in tasks {
            let formattedDueDate = Date(timeIntervalSince1970: task.createdDate).formatted(date: .abbreviated, time: .omitted)
            if !createdDates.contains(formattedDueDate) {
                createdDates.append(formattedDueDate)
            }
        }
        return createdDates
    }
    
    // Get tasks for Created
    func tasksForCreatedDate(tasks: [TaskItem], createdDate: String) -> [TaskItem] {
        let filteredTasks = tasks.filter { task in
            let formattedDueDate = Date(timeIntervalSince1970: task.createdDate).formatted(date: .abbreviated, time: .omitted)
            return formattedDueDate == createdDate
        }
        return filteredTasks
    }
    
    // Delete task from TasksList
//    func delete(id: String) {
//        let db = Firestore.firestore()
//
//        db.collection("users")
//            .document(userId)
//            .collection("tasks")
//            .document(id)
//            .delete()
//    }
    
    // Update pushDate
//    func pushDue(task: TaskItem) {
//        var taskCopy = task
//        taskCopy.dueDate = task.dueDate
//        
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return
//        }
//        
//        taskCopy.dueDate = task.dueDate + 24 * 60 * 60
//        
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(uid)
//            .collection("tasks")
//            .document(taskCopy.id)
//            .setData(taskCopy.asDictionary())
//    }

}
