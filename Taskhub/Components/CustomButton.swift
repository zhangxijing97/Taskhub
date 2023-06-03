//
//  CustomButton.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let isDisabled: Bool
    let isLoading: Bool
    let onPress: () -> Void
    
    var body: some View {
        Button {
            onPress()
        } label: {
            if !isLoading {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(Color(red: 0.1725, green: 0.1725, blue: 0.1804))
                    HStack {
                        Text(title)
                    }
                    .foregroundColor(Color.white)
                    .bold()
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(Color(red: 0.1725, green: 0.1725, blue: 0.1804))
                    ProgressView()
                        .scaleEffect(1.2)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .disabled(isDisabled)
        .animation(.easeInOut(duration: 0.5), value: isDisabled)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "sign in", isDisabled: true, isLoading: true) {
            print("tapped")
        }
    }
}
