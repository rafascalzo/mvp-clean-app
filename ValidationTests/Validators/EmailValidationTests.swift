//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Rafael Scalzo on 05/05/22.
//

import XCTest
import Presentation
import Validation

class EmailValidationTests: XCTestCase {
    
    func test_validate_should_return_error_if_invalid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        emailValidatorSpy.simulateInvalidEmail()
        let sut = makeSut(fieldName: "email", validationError: .invalid_email, emailValidator: emailValidatorSpy)
        XCTAssertThrowsError( try sut.validate(data: ["email":"any_invalid_email"]))
    }
    
    func test_validate_should_return_error_with_correct_validation_error() {
        let emailValidatorSpy = EmailValidatorSpy()
        emailValidatorSpy.simulateInvalidEmail()
        let sut = makeSut(fieldName: "email", validationError: .invalid_email, emailValidator: emailValidatorSpy)
        XCTAssertThrowsError(try sut.validate(data: ["email":"any_invalid_email"])) { error in
            guard let error = error as? ValidationError else {
                XCTFail("Expected error")
                return
            }
            XCTAssertEqual(error, .invalid_email)
        }
    }
    
    func test_validate_should_return_nil_if_valid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", validationError: .invalid_email, emailValidator: emailValidatorSpy)
        XCTAssertNoThrow(try sut.validate(data: ["email":"valid_email@apple.com"]))
    }
    
    func test_validate_should_return_error_if_no_data_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", validationError: .invalid_email, emailValidator: emailValidatorSpy)
        XCTAssertThrowsError( try sut.validate(data: nil))
    }
}

extension EmailValidationTests {
    
    func makeSut(fieldName: String, validationError: ValidationError, emailValidator: EmailValidator, file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = EmailValidation(fieldName: fieldName, validationError: validationError, emailValidator: emailValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
