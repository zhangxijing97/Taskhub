//
//  LoginTransitionText.swift
//  Taskhub
//
//  Created by 张熙景 on 6/1/23.
//

import SwiftUI

struct LoginTransitionText: View {
    
    @State var timerModel = TimerModel()
    @State private var textIndex = 0
    
    private let texts = [
//        HStack {
//            Text("")
//            Image(systemName: "circle.fill")
//            Text("")
//        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Log in")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("")
        },
        HStack {
            Text("")
            Image(systemName: "circle.fill")
            Text("Welcome back")
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
            .foregroundColor(.white)
            .frame(height: 192)
            .transition(.opacity)
            .onReceive(timerModel.textTimer) { _ in
                withAnimation(.default) {
                    if textIndex >= 3 { // Back to 0
                        textIndex = 0
                    } else {
                        textIndex = (textIndex + 1) % texts.count
                    }
                }
            }
    }
}

struct LoginTransitionText_Previews: PreviewProvider {
    static var previews: some View {
        LoginTransitionText()
    }
}
