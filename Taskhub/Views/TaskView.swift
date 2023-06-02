//
//  TaskView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct TaskView: View {
    @StateObject var viewModel = TaskViewModel()
    let task: TaskItem
    
    var body: some View {
        HStack {
//            VStack(alignment: .leading) {
//                Text(task.title)
//                    .font(.title3)
//
//                if task.dueDate < Date().timeIntervalSince1970 && task.isDone == false {
//                    HStack(spacing: 0) {
//                        Text("Due: ")
//                        Text("\(Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .shortened))")
//                    }
//                    .font(.footnote)
//                    .foregroundColor(.red)
//
//                } else {
//                    HStack(spacing: 0) {
//                        Text("Due: ")
//                        Text("\(Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .shortened))")
//                    }
//                    .font(.footnote)
//                    .foregroundColor(Color(.secondaryLabel))
//                }
//            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Due: \(formattedDueDate)")
                    .font(.subheadline)
                    .foregroundColor(dueDateColor)
            }
            
            Spacer()
            
            Button {
                // Update
                viewModel.toggleIsDone(task: task)
            } label: {
//                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
//                    .foregroundColor(.black)
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(task.isDone ? .green : .gray)
                    .frame(width: 24, height: 24)
            }
        }
    }
    
    private var formattedDueDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: Date(timeIntervalSince1970: task.dueDate))
    }
    
    private var dueDateColor: Color {
        if task.dueDate < Date().timeIntervalSince1970 && !task.isDone {
            return .red
        } else {
            return .secondary
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: .init(
            id: "id",
            title: "title",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        ))
    }
}
