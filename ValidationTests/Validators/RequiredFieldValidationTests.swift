//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by Rafael Scalzo on 27/04/22.
//

import Foundation
import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {
    
    func test_validate_should_return_error_if_field_is_not_provided() {
        let sut = makeSut(fieldName: "email", validationError: .required_email)
        XCTAssertThrowsError(try sut.validate(data: ["":"Test"]))
    }
    
    func test_validate_should_return_error_with_correct_validation_error() {
        let sut = makeSut(fieldName: "password", validationError: .required_password)
        XCTAssertThrowsError(try sut.validate(data: ["name":"Rudolph"])) { error in
            guard let error = error as? ValidationError else {
                XCTFail("Should return validation")
                return
            }
            XCTAssertEqual(error, ValidationError.required_password)
        }
    }
    
    func test_validate_should_return_nil_if_field_is_provided() {
        let sut = makeSut(fieldName: "name", validationError: .required_name)
        XCTAssertNoThrow(try sut.validate(data: ["name":"Rudolph"]))
    }
    
    func test_validate_should_return_error_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "name", validationError: .required_name)
        XCTAssertThrowsError(try sut.validate(data: nil))
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, validationError: ValidationError, file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, validationError: validationError)
        checkMemoryLeak(for: sut)
        return sut
    }
}
