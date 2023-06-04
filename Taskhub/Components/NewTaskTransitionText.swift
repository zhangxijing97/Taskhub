//
//  NewTaskTransitionText.swift
//  Taskhub
//
//  Created by 张熙景 on 6/4/23.
//

import SwiftUI

struct NewTaskTransitionText: View {
    
    @State var timerModel = TimerModel()
    @State private var textIndex = 0
    
    private let texts = [
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Create a New Task")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("Create a New Task")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("New Adventures")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("New Adventures")
        },
        HStack {
            Text("")
            Image(systemName: "checkmark.circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        }
    ]
    
    var body: some View {
        texts[textIndex]
            .font(.system(size: 32))
            .bold()
            .foregroundColor(.black)
            .frame(height: 192)
            .transition(.opacity)
            .onReceive(timerModel.textTimer) { _ in
                withAnimation(.default) {
                    if textIndex >= 7 { // Back to 0
                        textIndex = 0
                    } else {
                        textIndex = (textIndex + 1) % texts.count
                    }
                }
            }
    }
}

struct NewTaskTransitionText_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskTransitionText()
    }
}
