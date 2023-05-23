//
//  TasksListViewViewModel.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import FirebaseFirestore
import Foundation

class TasksListViewViewModel: ObservableObject {
    @Published var showingNewTaskView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    // Delete task from TasksList
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("tasks")
            .document(id)
            .delete()
    }
}
