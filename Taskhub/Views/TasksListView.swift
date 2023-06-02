//
//  TasksListView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct TasksListView: View {
    @StateObject var viewModel: TasksListViewModel
    @FirestoreQuery var tasks: [TaskItem]
    
    init(userId: String) {
        self._tasks = FirestoreQuery(collectionPath: "users/\(userId)/tasks")
        self._viewModel = StateObject(wrappedValue: TasksListViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Tasks in Progress")) {
                    ForEach(tasks, id: \.id) { task in
                        TaskView(task: task)
                            .swipeActions {
                                Button("Delete") {
                                    // Delete
                                    viewModel.delete(id: task.id)
                                }
                                .tint(.red)
                            }
                    }
                }
                Section(header: Text("Completed Tasks")) {
                    ForEach(tasks, id: \.id) { task in
                        TaskView(task: task)
                            .swipeActions {
                                Button("Delete") {
                                    // Delete
                                    viewModel.delete(id: task.id)
                                }
                                .tint(.red)
                            }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                Button {
                    viewModel.showingNewTaskView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewTaskView) {
                NewTaskView(newTaskPresented: $viewModel.showingNewTaskView)
            }
        }
    }
}

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(userId: "avDG0EoPQGdxx6TZ9vXLxETtU0N2")
    }
}
