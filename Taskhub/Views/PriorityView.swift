//
//  PriorityView.swift
//  Taskhub
//
//  Created by 张熙景 on 6/2/23.
//

import SwiftUI

struct PriorityView: View {
    @StateObject var viewModel: TasksListViewModel
    var tasks: [TaskItem]
    
    var body: some View {
        let sortedTasks = viewModel.sortTasksByDueDateLateFirst(tasks: tasks)
        let dueDates = viewModel.getDueDates(tasks: sortedTasks)
        
        ForEach(dueDates, id: \.self) { dueDate in
            let today = Date().formatted(date: .abbreviated, time: .omitted)as String
            
            Section(header: Text("Due: \(dueDate)")) {
                // Get all tasks for the DueDate
                let tasksForDueDate = viewModel.tasksForDueDate(tasks: tasks, dueDate: dueDate)
                
                // Uncompleted Tasks
                let uncompletedTasks = viewModel.filterUncompletedTasks(tasks: tasksForDueDate)
                let sortedUncompletedTasks = viewModel.sortTasksByDueDateEarlyFirst(tasks: uncompletedTasks)
                ForEach(sortedUncompletedTasks, id: \.id) { task in
                    TaskView(userId: viewModel.userId, task: task)
                }
                
                // Completed Tasks
                let completedTasks = viewModel.filterCompletedTasks(tasks: tasksForDueDate)
                let sortedCompletedTasks = viewModel.sortTasksByDueDateLateFirst(tasks: completedTasks)
                ForEach(sortedCompletedTasks, id: \.id) { task in
                    TaskView(userId: viewModel.userId, task: task)
                }
            }
        }
    }
}

struct PriorityView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(userId: "avDG0EoPQGdxx6TZ9vXLxETtU0N2")
//        PriorityView()
    }
}
