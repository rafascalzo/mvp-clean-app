//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Rafael Scalzo on 05/05/22.
//

import XCTest
import Presentation
import Validation

class ValidationCompositeTests: XCTestCase {
    
    func test_validate_should_throw_error_if_validation_fail() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError(.invalid_email)
        XCTAssertThrowsError(try sut.validate(data: ["email":"any_invalid_email"]))
    }
    
    func test_validate_should_return_correct_error_message() {
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2])
        validationSpy2.simulateError(.required_name)
      
        XCTAssertThrowsError(try sut.validate(data: ["email":"any_invalid_email"])) { error in
            guard let error = error as? ValidationError else {
                XCTFail("Expected Validation error")
                return
            }
            XCTAssertEqual(error, .required_name)
        }
    }
    
    func test_validate_should_return_first_error_message() {
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2, validationSpy3])
        validationSpy2.simulateError(.required_name)
        validationSpy3.simulateError(.invalid_email)
        XCTAssertThrowsError(try sut.validate(data: ["email":"any_invalid_email"])) { error in
            guard let error = error as? ValidationError else {
                XCTFail("Expected Validation error")
                return
            }
            XCTAssertEqual(error, .required_name)
        }
    }
    
    func test_validate_should_call_validation_with_correct_data() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name":"Rudolph"]
        do {
            try sut.validate(data: data)
            XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
        } catch {
            XCTFail("Expected Success")
        }
    }
}

extension ValidationCompositeTests {
    func makeSut(validations: [Validation], file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
