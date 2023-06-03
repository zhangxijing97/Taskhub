//
//  DefaultView.swift
//  Taskhub
//
//  Created by 张熙景 on 6/2/23.
//

import SwiftUI

struct DefaultView: View {
    @StateObject var viewModel: TasksListViewModel
    var tasks: [TaskItem]
    @State private var selectedTask: TaskItem?
    @State private var showActionSheet = false
    
    var body: some View {
        Section {
            
            // Uncompleted Tasks
            let uncompletedTasks = viewModel.filterUncompletedTasks(tasks: tasks)
            let sortedUncompletedTasks = viewModel.sortTasksByDueDateEarlyFirst(tasks: uncompletedTasks)
            ForEach(sortedUncompletedTasks, id: \.id) { task in
                TaskView(userId: viewModel.userId, task: task)
            }
            
            // Completed Tasks
            let completedTasks = viewModel.filterCompletedTasks(tasks: tasks)
            let sortedCompletedTasks = viewModel.sortTasksByDueDateLateFirst(tasks: completedTasks)
            ForEach(sortedCompletedTasks, id: \.id) { task in
                TaskView(userId: viewModel.userId, task: task)
            }
        }
    }
}

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(userId: "avDG0EoPQGdxx6TZ9vXLxETtU0N2")
//        DefaultView()
    }
}
