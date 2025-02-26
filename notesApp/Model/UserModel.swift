//
//  UserModel.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 7.02.2025.
//

import Foundation

struct UserModel {
    let userId: String
    let name: String
    let surname: String
    let email: String
    let joined: TimeInterval
    
    func toFirestoreDictionary() -> [String: Any] {
        return [
            "userId": userId,
            "name": name,
            "surname": surname,
            "email": email,
            "joined": joined
        ]
    }
}
