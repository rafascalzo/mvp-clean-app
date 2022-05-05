//
//  CompareFieldsValidation.swift
//  Validation
//
//  Created by Rafael Scalzo on 05/05/22.
//

import Foundation
import Presentation

public final class CompareFieldsValidation: Validation, Equatable {
    
    private let fieldName: String
    private let fieldNameToCompare: String
    private let validationError: ValidationError
    
    public init(fieldName: String, fieldNameToCompare: String ,validationError: ValidationError) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.validationError = validationError
    }
    
    public func validate(data: [String : Any]?) throws {
        guard data != nil, data![fieldName] as? String == data![fieldNameToCompare] as? String else { throw validationError }
    }
    
    public static func == (lhs: CompareFieldsValidation, rhs: CompareFieldsValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.fieldNameToCompare == rhs.fieldNameToCompare && lhs.validationError == rhs.validationError
    }
}
