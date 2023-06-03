//
//  CreatedDateView.swift
//  Taskhub
//
//  Created by 张熙景 on 6/2/23.
//

import SwiftUI

struct CreatedDateView: View {
    @StateObject var viewModel: TasksListViewModel
    var tasks: [TaskItem]
    
    var body: some View {
        let sortedTasks = viewModel.sortTasksByCreatedDateLateFirst(tasks: tasks)
        let createdDates = viewModel.getCreatedDates(tasks: sortedTasks)
        
        ForEach(createdDates, id: \.self) { createdDate in
            
            Section(header: Text(createdDate)) {
                // Get all tasks for the DueDate
                let tasksForCreatedDate = viewModel.tasksForCreatedDate(tasks: tasks, createdDate: createdDate)
                
                // Uncompleted Tasks
                let uncompletedTasks = viewModel.filterUncompletedTasks(tasks: tasksForCreatedDate)
                let sortedUncompletedTasks = viewModel.sortTasksByDueDateEarlyFirst(tasks: uncompletedTasks)
                ForEach(sortedUncompletedTasks, id: \.id) { task in
                    TaskView(userId: viewModel.userId, task: task)
                }
                
                // Completed Tasks
                let completedTasks = viewModel.filterCompletedTasks(tasks: tasksForCreatedDate)
                let sortedCompletedTasks = viewModel.sortTasksByDueDateLateFirst(tasks: completedTasks)
                ForEach(sortedCompletedTasks, id: \.id) { task in
                    TaskView(userId: viewModel.userId, task: task)
                }
            }
            
        }
    }
}

struct CreatedDateView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(userId: "avDG0EoPQGdxx6TZ9vXLxETtU0N2")
//        CreatedDateView()
    }
}
