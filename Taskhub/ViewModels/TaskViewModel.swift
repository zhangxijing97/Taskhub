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
}
