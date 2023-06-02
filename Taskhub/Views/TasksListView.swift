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
        // initializes the userId pass from HomeView to viewModel
        self._viewModel = StateObject(wrappedValue: TasksListViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    // Uncompleted Tasks
                    let uncompletedTasks = viewModel.filterUncompletedTasks(tasks: tasks)
                    let sortedUncompletedTasks = viewModel.sortTasksByDueDate(tasks: uncompletedTasks)
                    ForEach(sortedUncompletedTasks, id: \.id) { task in
                        TaskView(task: task)
                            .swipeActions {
                                Button("Delete") {
                                    // Delete
                                    viewModel.delete(id: task.id)
                                }
                                .tint(.red)
                            }
                    }
                    // Completed Tasks
                    let completedTasks = viewModel.filterCompletedTasks(tasks: tasks)
                    let sortedCompletedTasks = viewModel.sortTasksByDueDate(tasks: completedTasks)
                    ForEach(sortedCompletedTasks, id: \.id) { task in
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
