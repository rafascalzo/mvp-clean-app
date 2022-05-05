//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Rafael Scalzo on 05/05/22.
//

import Foundation
import Presentation

public final class RequiredFieldValidation: Validation, Equatable {
    
    private let fieldName: String
    private let validationError: ValidationError
    
    public init(fieldName: String, validationError: ValidationError) {
        self.fieldName = fieldName
        self.validationError = validationError
    }
    
    public func validate(data: [String : Any]?) throws {
        guard data != nil else { throw validationError }
        guard let fieldValue = data?[fieldName] as? String, !fieldValue.isEmpty else {
            throw validationError
        }
    }
    
    public static func ==(lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.validationError == rhs.validationError
    }
}
