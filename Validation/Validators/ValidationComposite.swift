//
//  ValidationComposite.swift
//  Validation
//
//  Created by Rafael Scalzo on 05/05/22.
//

import Foundation
import Presentation

public final class ValidationComposite: Validation {
    
    private let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
    
    public func validate(data: [String : Any]?) throws {
        for validation in validations {
            do {
                try validation.validate(data: data)
            } catch {
                throw error
            }
        }
    }
}
