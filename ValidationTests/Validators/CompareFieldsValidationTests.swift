//
//  CompareFieldsValidationTests.swift
//  ValidationTests
//
//  Created by Rafael Scalzo on 05/05/22.
//

import Foundation
import XCTest
import Presentation
import Validation

class CompareFieldsValidationTests: XCTestCase {
    
    func test_validate_should_return_error_if_password_not_match() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", validationError: .password_not_match)
        XCTAssertThrowsError(try sut.validate(data: ["password":"123","passwordConfirmation": "abc"]))
    }
    
    func test_validate_should_return_error_correct_error() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", validationError: .password_not_match)
        XCTAssertThrowsError(try sut.validate(data: ["password":"123","passwordConfirmation":"abc"])) { error in
            guard let error = error as? ValidationError else {
                XCTFail("Should return validation")
                return
            }
            XCTAssertEqual(error, ValidationError.password_not_match)
        }
    }
    
    func test_validate_should_return_nil_if_password_match() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", validationError: .password_not_match)
        XCTAssertNoThrow(try sut.validate(data: ["password":"123", "passwordConfirmation":"123"]))
    }
    
    func test_validate_should_return_error_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", validationError: .password_not_match)
        XCTAssertThrowsError(try sut.validate(data: nil))
    }
}

extension CompareFieldsValidationTests {
    func makeSut(fieldName: String, fieldNameToCompare: String, validationError: ValidationError, file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = CompareFieldsValidation(fieldName: fieldName,fieldNameToCompare: fieldNameToCompare ,validationError: validationError)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
