//
//  NewTaskViewModel.swift
//  Taskhub
//
//  Created by 张熙景 on 5/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewTaskViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        
        // Get Current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create model
        let newId = UUID().uuidString
        let newTask = TaskItem(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        )
        
        // Save model to db
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("tasks")
            .document(newId)
            .setData(newTask.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
