//
//  TimerModel.swift
//  Taskhub
//
//  Created by 张熙景 on 6/1/23.
//

import Foundation

class TimerModel: ObservableObject {
    
    // Every 3 second, the timer will change
    @Published var textTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // Every 6 second, the timer will change
    @Published var colorTimer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    
}
