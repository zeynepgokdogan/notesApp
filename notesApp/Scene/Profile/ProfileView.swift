//
//  ProfileView.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 18.02.2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var isUserLoggedOut = false
    @StateObject var viewModel = ProfileViewViewModel(userId: "123")
    
    var body: some View {
        if isUserLoggedOut {
            LoginView()
        } else {
            NavigationStack {
                VStack {
                    if let user = viewModel.userdata {
                        VStack(spacing: 10) {
                            Text("Ad: \(user.name)")
                                .font(.title2)
                                .bold()
                            Text("Soyad: \(user.surname)")
                                .font(.title3)
                        }
                        .padding()
                    } else {
                        ProgressView("Loading...")
                    }
                }
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            viewModel.signOut()
                        }) {
                            Image(systemName: "power.circle.fill")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    ProfileView()
}

