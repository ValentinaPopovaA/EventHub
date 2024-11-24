//
//  Validator.swift
//  EventHub
//
//  Created by Максим on 23.11.2024.
//

import Foundation


class Validator {
    
    static func isValidEmail(for email: String) -> Bool {
        
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
                                    
    }
    
    
    static func isValidUserName(for username: String) -> Bool {
        
        let name = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let userRegEx = "\\w{4,24}"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", userRegEx)
        return usernamePred.evaluate(with: name)
                                    
    }
    
    static func isValidPassword(for password: String) -> Bool {
        
        let pass = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{6,32}$"
        let password = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return password.evaluate(with: pass)
                                    
    }
    
    
}
