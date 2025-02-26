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
    
    var body: some View {
        if isUserLoggedOut {
            LoginView()
        } else {
            NavigationStack {
                VStack {
                    Text("Profile Page")
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            signOut()
                        }) {
                            Image(systemName: "power.circle.fill")
                                .foregroundColor(.red)
                                .font(.title2)
                        }
                    }
                }
            }
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("✅ Kullanıcı başarıyla çıkış yaptı.")
            isUserLoggedOut = true
        } catch {
            print("❌ Çıkış yaparken hata oluştu: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ProfileView()
}
