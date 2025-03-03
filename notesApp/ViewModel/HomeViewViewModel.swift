//
//  HomeViewViewModel.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 18.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class HomeViewViewModel: ObservableObject {
    @Published var notes: [NoteModel] = []
    @Published var showNotes: Bool = false
    
    private let db = Firestore.firestore()
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        fetchNotes()
    }
    
    func filteredNotes(_ searchText: String) -> [NoteModel] {
        guard !searchText.isEmpty else {
            return notes
        }
        
        return notes.filter { note in
            note.title.lowercased().contains(searchText.lowercased()) ||
            note.content.lowercased().contains(searchText.lowercased())
        }
    }
    
    func fetchNotes() {
        db.collection("users")
            .document(userId)
            .collection("notes")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching notes: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                DispatchQueue.main.async {
                    self.notes = documents.compactMap { doc -> NoteModel? in
                        let data = doc.data()
                        guard let id = data["id"] as? String,
                              let title = data["title"] as? String,
                              let content = data["content"] as? String,
                              let createdAt = data["createdAt"] as? TimeInterval else {
                            return nil
                        }
                        return NoteModel(id: id, title: title, content: content, createdAt: createdAt)
                    }
                }
            }
    }
    
    func deleteNote(note: NoteModel) {
        db.collection("users")
            .document(userId)
            .collection("notes")
            .document(note.id)
            .delete { error in
                if let error = error {
                    print("Error deleting note: \(error)")
                }
            }
    }
    
    func updateNote(note: NoteModel) {
        db.collection("users")
            .document(userId)
            .collection("notes")
            .document(note.id)
            .updateData([
                "title": note.title,
                "content": note.content
            ]) { error in
                if let error = error {
                    print("Error updating note: \(error)")
                }
            }
    }
}

