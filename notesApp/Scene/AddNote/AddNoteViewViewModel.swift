//
//  AddNoteViewViewModel.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 18.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AddNoteViewViewModel: ObservableObject {
    @Published var noteTitle: String = ""
    @Published var noteContent: String = ""
    @Published var showAlert: Bool = false
    
    func save(){
        guard canSave else{
            return
        }
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        let newItemId = UUID().uuidString
        let newItem: NoteModel = NoteModel(id: newItemId, title: noteTitle, content: noteContent, createdAt: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        let noteData  = newItem.toFirestoreDictionary()
        db.collection("users")
            .document(userId)
            .collection("notes")
            .document(newItem.id)
            .setData(noteData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
                self.showAlert = true
            }
        }
    }
    var canSave: Bool{
        guard !noteTitle.isEmpty else { return false }
        return true
    }
    
    
}
