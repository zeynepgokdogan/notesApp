//
//  LoginViewModel.swift
   //
//  Created by Zeynep Gökdoğan on 7.02.2025.
//

import Foundation

class LoginViewViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    func login() {
        guard validate() else{
            return
        }
    }
    
    func validate() -> Bool{
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
            !password.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            errorMessage = "Please Enter all fields"
            return false
        }
        guard email.contains( "@" ) && email.contains(".") else{
            errorMessage = "Invalid Email"
            return false
        }
        return true
    }
    
    
}
