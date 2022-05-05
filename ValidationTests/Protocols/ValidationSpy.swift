//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Rafael Scalzo on 05/05/22.
//

import Foundation
import Presentation

class ValidationSpy: Validation {
    
    var error: ValidationError?
    var data: [String:Any]?
    
    func validate(data: [String : Any]?) throws {
        self.data = data
        if let error = error {
            throw error
        }
    }
    
    func simulateError(_ error: ValidationError) {
        self.error = error
    }
}
