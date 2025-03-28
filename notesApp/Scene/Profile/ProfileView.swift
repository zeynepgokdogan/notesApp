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
    @StateObject var viewModel: ProfileViewViewModel
    
    init() {
        if let currentUserID = Auth.auth().currentUser?.uid {
            _viewModel = StateObject(wrappedValue: ProfileViewViewModel(userId: currentUserID))
        } else {
            _viewModel = StateObject(wrappedValue: ProfileViewViewModel(userId: ""))
            isUserLoggedOut = true
        }
    }
    
    var body: some View {
        if isUserLoggedOut {
            LoginView()
        } else {
            NavigationStack {
                VStack {
                    if let user = viewModel.userdata {
                        VStack(spacing: 20) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .padding(.top, 20)
                            
                            VStack(spacing: 10) {
                                Text("\(user.name) \(user.surname)")
                                    .font(.title)
                                    .bold()
                                
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                        .padding()
                        .frame(height: 350)
                    } else {
                        ProgressView("Loading...")
                            .padding()
                    }
                    
                }
                .padding()
                .toolbar{
                    Button(action: {
                        viewModel.signOut()
                        isUserLoggedOut = true
                    }) {
                        HStack {
                            Text("Log Out")
                                .font(.headline)
                                .bold()
                            Image(systemName: "power.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.yellow)
                            
                        }
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }}
            }
        }
    }
}

#Preview {
    ProfileView()
}

