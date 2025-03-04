//
//  MainViewModel.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 7.02.2025.
//


import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    
    @Published var currentUserId: String = ""
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    deinit {
        if let handle = authStateListenerHandle {
             Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    public var isSignIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
