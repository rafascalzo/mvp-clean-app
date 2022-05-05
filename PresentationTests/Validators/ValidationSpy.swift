//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Rafael Scalzo on 26/04/22.
//

import Foundation
import Presentation

class ValidationSpy : Validation {
    
    var data: [String:Any]?
    var error: ValidationError?
    
    func validate(data: [String : Any]?) throws {
        self.data = data
        throw error!
    }
    
    func simulate(error: ValidationError) {
        self.error = error
    }
}
