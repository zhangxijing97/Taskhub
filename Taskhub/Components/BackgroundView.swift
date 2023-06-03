//
//  BackgroundView.swift
//  Taskhub
//
//  Created by 张熙景 on 6/1/23.
//

import SwiftUI

struct BackgroundView: View {
    @State var timerModel = TimerModel()
    @State private var colorIndex = 0
    
    private let colors = [
        Color(red: 0.0000, green: 0.3294, blue: 0.3294),
        Color(red: 0.0941, green: 0.2157, blue: 0.0902),
        Color(red: 0.8510, green: 1.0000, blue: 0.8471),
        Color(red: 0.2039, green: 0.2000, blue: 0.1333),
        Color(red: 0.9961, green: 0.4627, blue: 0.0000),
        Color(red: 0.0039, green: 0.0000, blue: 0.1804),
        Color(red: 1.0000, green: 0.2667, blue: 1.0000),
        Color(red: 0.1529, green: 0.0118, blue: 0.2902)
    ]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .foregroundColor(colors[colorIndex])
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

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
