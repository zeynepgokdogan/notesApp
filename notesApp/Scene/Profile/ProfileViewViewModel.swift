//
//  ProfileViewViewModel.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 18.02.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProfileViewViewModel: ObservableObject {
    @Published var userdata: UserModel?
    @Published var isUserLoggedOut = false
    
    private let db = Firestore.firestore()
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        fetchUserData()
    }
    
    func fetchUserData() {
        db.collection("users").document(userId).addSnapshotListener { snapshot, error in
            if let error = error {
                print("Kullanıcı verisi alınırken hata oluştu: \(error.localizedDescription)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print("Kullanıcı verisi bulunamadı.")
                return
            }
            
            DispatchQueue.main.async {
                self.userdata = UserModel(
                    userId: self.userId,
                    name: data["name"] as? String ?? "Bilinmiyor",
                    surname: data["surname"] as? String ?? "Bilinmiyor",
                    email: data["email"] as? String ?? "Bilinmiyor"
                )
            }
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("Kullanıcı başarıyla çıkış yaptı.")
            isUserLoggedOut = true
        } catch {
            print("Çıkış yaparken hata oluştu: \(error.localizedDescription)")
        }
    }
}

