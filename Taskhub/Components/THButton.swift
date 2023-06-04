//
//  THButton.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct THButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            // Action
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundColor(background)
                HStack {
                    Text(title)
                }
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        
    }
}

struct THButton_Previews: PreviewProvider {
    static var previews: some View {
        THButton(title: "title", background: .blue) {
            // Action
        }
    }
}
