//
//  EmailValidation.swift
//  Validation
//
//  Created by Rafael Scalzo on 05/05/22.
//

import Foundation
import Presentation

public final class EmailValidation: Validation, Equatable {
    
    public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.validationError == rhs.validationError
    }
    
    
    private let fieldName: String
    private let validationError: ValidationError
    private let emailValidator: EmailValidator
    
    public init(fieldName: String, validationError: ValidationError, emailValidator: EmailValidator) {
        self.fieldName = fieldName
        self.validationError = validationError
        self.emailValidator = emailValidator
    }
    
    public func validate(data: [String : Any]?) throws {
        guard let fieldValue = data?[fieldName] as? String, emailValidator.isValid(email: fieldValue) else {
            throw validationError
        }
    }
}
