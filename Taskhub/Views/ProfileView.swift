//
//  ProfileView.swift
//  Taskhub
//
//  Created by 张熙景 on 5/29/23.
//

import SwiftUI
import MessageUI
import FirebaseFirestoreSwift

struct ProfileView: View {
    @EnvironmentObject var authStore: AuthStore
    @State private var isSheetPresented = false
    @State private var sheetContent = ""
    
    var body: some View {
        NavigationView {
            List {
                
                // Profile
                Section {
                    NavigationLink(destination: ProfileDetailView()) {
                        HStack(spacing: 16) {
                            if authStore.user?.photoUrl != nil {
                                AsyncImage(url: authStore.user?.photoUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                                        .frame(width: 60, height: 60)
                                }
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                                    .frame(width: 60, height: 60)
                            }
                            VStack(alignment: .leading) {
                                if authStore.user?.name != "" {
                                    Text(authStore.user?.name ?? "Anonymous")
                                        .font(.title2)
                                } else {
                                    Text("Anonymous")
                                        .font(.title2)
                                }
                                Text("Personal Information")
                            }
                        }
                    }
                }
                
                // Info
                Section {
                    NavigationLink(destination: ProfileDetailView()) {
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .foregroundColor(.blue)
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 29, height: 29)
                            
                            Text(authStore.user?.email ?? "Loading")
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    
                    NavigationLink(destination: ProfileDetailView()) {
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .foregroundColor(.green)
                                Text("UID")
                                    .font(.system(size: 13))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .frame(width: 29, height: 29)
                            
                            Text(authStore.user?.id.uppercased() ?? "Loading")
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                }

                // Application info
                Section {
                    NavigationLink(destination: HelpSupportView()) {
                        Text("Help & Support")
                    }
                    
                    NavigationLink(destination: TermsOfUseView()) {
                        Text("Terms of Use")
                    }
                    
                    HStack {
                        Text("Taskhub for iOS Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                }
                
                // Sign out
                Section() {
                    VStack(alignment: .center) {
                        Button {
                            Task {
                                authStore.logout()
                            }
                        } label: {
                            ZStack(alignment: .center) {
                                Text("Sign out")
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileDetailView: View {
    @EnvironmentObject var authStore: AuthStore
    
    var body: some View {
        ScrollView {
            VStack(spacing: 48) {
                if let user = authStore.user {
                    VStack(spacing: 16) {
                        if let photoUrl = user.photoUrl {
                            AsyncImage(url: photoUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } placeholder: {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 120))
                                    .foregroundColor(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                                    .frame(width: 120, height: 120)
                            }
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 120))
                                .foregroundColor(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                                .frame(width: 120, height: 120)
                        }
                        
                        if authStore.user?.name != "" {
                            Text(user.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        } else {
                            Text("Anonymous")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 16)
                    
                    VStack(spacing: 16) {
                        Text(user.email)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("UID: \(user.id.uppercased())")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 24)
                }
            }
            .navigationBarTitle("Taskhub ID", displayMode: .inline)
        }
    }
}

struct HelpSupportView: View {
    @State private var isShowingMailView = false
    
    var body: some View {
        ScrollView {
            AuthTransitionText()
                .frame(height: 192)
            
            VStack(spacing: 48) {
                Text("Need Help or Support?")
                    .font(.title)
                    .bold()
                
                Text("If you have any questions or need assistance, please feel free to contact our support team.")
                    .multilineTextAlignment(.center)
                
                THButton(title: "Contact Support", background: .blue) {
                    isShowingMailView = true
                }
            }
            .padding(24)
        }
        .sheet(isPresented: $isShowingMailView, onDismiss: {
            isShowingMailView = false
        }) {
            MailView(recipients: ["zhangxijing97@gmail.com"], subject: "Support Request: ")
        }
        .navigationBarTitle("Help & Support", displayMode: .inline)
    }
}

struct MailView: UIViewControllerRepresentable {
    let recipients: [String]
    let subject: String
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        guard MFMailComposeViewController.canSendMail() else {
            fatalError("Cannot send mail")
        }
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.setToRecipients(recipients)
        mailComposeVC.setSubject(subject)
        mailComposeVC.mailComposeDelegate = context.coordinator
        return mailComposeVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // No need to implement anything here
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}

struct TermsOfUseView: View {
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Please read the following terms and conditions carefully before using our app.")
                        .font(.headline)
                    
                    TermText(title: "1. Usage Agreement", content: """
                    By using our app, you agree to comply with the following terms and conditions:
                    
                    a. You must use the app for lawful purposes only.
                    b. You may not use the app to transmit any harmful or malicious content.
                    c. You are responsible for maintaining the confidentiality of your account.
                    """)
                    
                    TermText(title: "2. Intellectual Property", content: """
                    Our app and its content are protected by intellectual property laws:
                    
                    a. You may not reproduce, distribute, or modify any part of the app without our permission.
                    b. You may use the app for personal, non-commercial purposes only.
                    """)
                    
                    TermText(title: "3. Privacy Policy", content: """
                    We respect your privacy and handle your personal information responsibly:
                    
                    a. We collect and store information as outlined in our Privacy Policy.
                    b. We may use cookies or similar technologies to improve your app experience.
                    """)
                    
                    TermText(title: "4. User Conduct", content: """
                    As a user of our app, you agree to the following conduct guidelines:
                    
                    a. You will not engage in any illegal, abusive, or harmful activities.
                    b. You will respect the rights and privacy of other app users.
                    c. You will not attempt to disrupt or interfere with the app's functionality.
                    """)
                    
                    TermText(title: "5. Termination", content: """
                    We reserve the right to terminate your access to the app if you violate these terms.
                    """)
                    
                    TermText(title: "6. Governing Law", content: """
                    These terms and your use of the app are governed by the laws of your jurisdiction.
                    
                    """)
                }
            }
        }
        .navigationBarTitle("Terms of Use", displayMode: .inline)
    }
}

struct TermText: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
            Text(content)
                .font(.body)
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
