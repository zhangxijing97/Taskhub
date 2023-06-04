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
    
    @State private var displayMode = "Priority"
    let displayModes = ["Priority", "Created Date", "Default"]
    @State private var searchText = "" // Search code part I
    
    init(userId: String) {
        self._tasks = FirestoreQuery(collectionPath: "users/\(userId)/tasks")
        // initializes the userId pass from HomeView to viewModel
        self._viewModel = StateObject(wrappedValue: TasksListViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            List {
                Picker("Display Mode", selection: $displayMode) {
                    ForEach(displayModes, id: \.self) { displayMode in
                        Text(displayMode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                if displayMode == "Priority" {
                    PriorityView(viewModel: viewModel, tasks: searchResults)
                } else if displayMode == "Created Date" {
                    CreatedDateView(viewModel: viewModel, tasks: searchResults)
                } else {
                    DefaultView(viewModel: viewModel, tasks: searchResults)
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
        .searchable(text: $searchText)
    }
    
    var searchResults: [TaskItem] { // Search code part III
        if searchText.isEmpty {
            return tasks
        } else {
            return tasks.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                Date(timeIntervalSince1970: $0.dueDate).formatted(date: .abbreviated, time: .shortened).localizedCaseInsensitiveContains(searchText) ||
                Date(timeIntervalSince1970: $0.createdDate).formatted(date: .abbreviated, time: .shortened).localizedCaseInsensitiveContains(searchText)
            }

        }
    }
}

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(userId: "avDG0EoPQGdxx6TZ9vXLxETtU0N2")
    }
}
