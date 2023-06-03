//
//  TaskView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct TaskView: View {
    @StateObject var viewModel = TaskViewModel()
    let userId: String
    let task: TaskItem
    @State private var showActionSheet = false
    
    var body: some View {
        HStack {
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
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(task.isDone ? .green : .gray)
                    .frame(width: 24, height: 24)
            }
            .swipeActions(edge: .trailing) {
                Button {
                    viewModel.delete(userId: userId, id: task.id)
                } label: {
                    Image(systemName: "trash.fill")
                }
                .tint(.red)
            }
            .swipeActions(edge: .leading) {
                Button {
                    showActionSheet = true
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                }
                .tint(.indigo)
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Push Due Date"),
                    message: Text("Choose the desired option to push the due date."),
                    buttons: [
                        .default(Text("One Day")) {
                            viewModel.pushDueOneDay(task: task)
                        },
                        .default(Text("One Week")) {
                            viewModel.pushDueOneWeek(task: task)
                        },
                        .default(Text("One Month")) {
                            viewModel.pushDueOneMonth(task: task)
                        },
                        .cancel()
                    ]
                )
            }
            
            
        }
        
    }
    
    private var formattedDueDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
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
        TaskView(userId: "avDG0EoPQGdxx6TZ9vXLxETtU0N2", task: .init(
            id: "id",
            title: "title",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        ))
    }
}
