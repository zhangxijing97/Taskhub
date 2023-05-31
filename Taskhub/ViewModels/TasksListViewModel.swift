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
