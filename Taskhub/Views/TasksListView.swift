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
            VStack {
                List(tasks) { task in
                    TaskView(task: task)
                        .swipeActions {
                            Button("Delete") {
                                // Delete
                                viewModel.delete(id: task.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(PlainListStyle())
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
        TasksListView(userId: "gbx0bIy3Poa0XxBfNCEJoofwhWv1")
    }
}
