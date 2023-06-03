//
//  TaskViewModel.swift
//  Taskhub
//
//  Created by 张熙景 on 5/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TaskViewModel: ObservableObject {
    
//    private let userId: String
    
    init() {}
    
    func toggleIsDone(task: TaskItem) {
        var taskCopy = task
        taskCopy.setDone(!task.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("tasks")
            .document(taskCopy.id)
            .setData(taskCopy.asDictionary())
    }
    
    // Delete task from TasksList
    func delete(userId: String, id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("tasks")
            .document(id)
            .delete()
    }
    
    // Push due date for one day
    func pushDueOneDay(task: TaskItem) {
        var taskCopy = task
        taskCopy.dueDate = task.dueDate
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        taskCopy.dueDate = task.dueDate + 24 * 60 * 60
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("tasks")
            .document(taskCopy.id)
            .setData(taskCopy.asDictionary())
    }
    
    func pushDueOneWeek(task: TaskItem) {
        var taskCopy = task
        taskCopy.dueDate = task.dueDate
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        taskCopy.dueDate = task.dueDate + 24 * 60 * 60 * 7
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("tasks")
            .document(taskCopy.id)
            .setData(taskCopy.asDictionary())
    }
    
    func pushDueOneMonth(task: TaskItem) {
        var taskCopy = task
        taskCopy.dueDate = task.dueDate
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        taskCopy.dueDate = task.dueDate + 24 * 60 * 60 * 30
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("tasks")
            .document(taskCopy.id)
            .setData(taskCopy.asDictionary())
    }
    
}
