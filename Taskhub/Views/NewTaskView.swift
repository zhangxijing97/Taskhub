//
//  NewTaskView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct NewTaskView: View {
    @StateObject var viewModel = NewTaskViewModel()
    @Binding var newTaskPresented: Bool
    
    // Default time to 10 AM
    @State private var selectedDate = Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date()) ?? Date()
    
    var body: some View {
        VStack {
            NewTaskTransitionText()
            
            TextField("Enter Task Title", text: $viewModel.title)
                .textFieldStyle(DefaultTextFieldStyle())
            
            DatePicker("Due Date", selection: $selectedDate)
                .datePickerStyle(GraphicalDatePickerStyle())
            
            THButton(title: "Create Task", background: .black) {
                if viewModel.canSave {
                    viewModel.dueDate = selectedDate // Default time to 10 AM
                    viewModel.save()
                    newTaskPresented = false
                } else {
                    viewModel.showAlert = true
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                    message: Text("Please fill in all fields and select due date that is today or newer.")
                )
            }
        }
        .padding(24)
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(newTaskPresented: Binding(get: {
            return true
        }, set: {_ in
            
        }))
    }
}
