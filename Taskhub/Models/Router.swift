//
//  Router.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
  
    func reset() {
        path = NavigationPath()
    }
}
