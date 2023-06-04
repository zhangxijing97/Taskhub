//
//  TransitionTextAuth.swift
//  Taskhub
//
//  Created by 张熙景 on 6/1/23.
//

import SwiftUI

struct AuthTransitionText: View {
    
    // Get the timer
    @State var timerModel = TimerModel()
    @State private var textIndex = 0
    @State private var colorIndex = 0
    
    private let texts = [
        // 0
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Taskhub")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Taskhub")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 1
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Read chapter one")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Read chapter one")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 2
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Write the blog")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Write the blog")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 3
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Donate unused items")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Donate unused items")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 4
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Plan the weekend")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Plan the weekend")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 5
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Learn a new recipe")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Learn a new recipe")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 6
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Yoga")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Yoga")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 7
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Start a journal")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Start a journal")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 8
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Calculus homework")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Calculus homework")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        
        // 9
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Attendance app")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Attendance app")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        }
        
    ]
    
    private let colors = [
        Color(red: 1.0000, green: 0.7882, blue: 0.5372),
        Color(red: 0.9961, green: 0.5451, blue: 0.9961),
        Color(red: 0.9961, green: 0.5451, blue: 0.9961),
        Color(red: 0.8980, green: 0.9412, blue: 0.9961),
        Color(red: 0.1020, green: 0.0000, blue: 0.9961),
        Color(red: 1.0000, green: 0.9608, blue: 0.2196),
        Color(red: 0.0000, green: 0.0000, blue: 0.0000),
        Color(red: 0.4863, green: 0.9451, blue: 0.4706)
    ]
    
    var body: some View {
        texts[textIndex]
            .font(.system(size: 32))
            .bold()
            .foregroundColor(colors[colorIndex])
            .transition(.opacity)
            .onReceive(timerModel.textTimer) { _ in
                withAnimation(.default) {
                    if textIndex >= 35 { // Back to 0
                        textIndex = 0
                    } else {
                        textIndex = (textIndex + 1) % texts.count
                    }
                }
            }
            .onReceive(timerModel.colorTimer) { _ in
                withAnimation(.default) {
                    if colorIndex >= 7 { // Back to 0
                        colorIndex = 0
                    } else {
                        colorIndex = (colorIndex + 1) % colors.count
                    }
                }
            }
    }
}

struct AuthTransitionText_Previews: PreviewProvider {
    static var previews: some View {
        AuthTransitionText()
    }
}
