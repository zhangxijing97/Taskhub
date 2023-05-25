//
//  HeaderView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/16/23.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let titleColor: Color
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 0)
//                .foregroundColor(background)
            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(titleColor)
                    .bold()
                
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(titleColor)
            }
//            .offset(y: -150)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "title", subtitle: "subtitle", titleColor: Color.blue)
    }
}
