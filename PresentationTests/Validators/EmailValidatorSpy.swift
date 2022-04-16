//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Rafael Scalzo on 16/04/22.
//

import Foundation
import Presentation

class EmailValidatorSpy: EmailValidator {
    
    var isValid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
}
