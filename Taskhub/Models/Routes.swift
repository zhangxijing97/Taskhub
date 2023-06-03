//
//  Routes.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

enum AuthenticatedRoutes {}

enum NotAuthenticatedRoutes: View {
    case SignupRoute

    var body: some View {
        switch self {
        case .SignupRoute:
            SignupView()
        }
    }
}
