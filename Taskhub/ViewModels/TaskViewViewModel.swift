//
//  TaskViewViewModel.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class TaskViewViewModel: ObservableObject {
    init() {}
    
    func toggleIsDone(task: Task) {
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
