//
//  HeaderView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let titleColor: Color
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(titleColor)
                    .bold()
                
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(titleColor)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "title", subtitle: "subtitle", titleColor: Color.blue)
    }
}
