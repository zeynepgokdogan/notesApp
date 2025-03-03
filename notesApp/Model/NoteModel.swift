//
//  NoteModel.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 25.02.2025.
//

import Foundation

struct NoteModel: Identifiable {
    let id: String
    let title: String
    let content: String
    let createdAt: TimeInterval
    
    func toFirestoreDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "content": content,
            "createdAt": createdAt
        ]
    }
}
