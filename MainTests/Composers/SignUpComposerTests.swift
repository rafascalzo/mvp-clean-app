//
//  SignUpComposerTests.swift
//  SignUpComposerTests
//
//  Created by Rafael Scalzo on 19/04/22.
//

import XCTest
import Main
import UI
import Validation

class SignUpComposerTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread()  {
        let (sut, createAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        let exp = expectation(description:  "waiting")
        DispatchQueue.global().async {
            createAccountSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_compose_with_correct_validations() {
        let validations = SignUpComposer.makeValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "name", validationError: .required_name))
        XCTAssertEqual(validations[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", validationError: .required_email))
        XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", validationError: .invalid_email, emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validations[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", validationError: .required_password))
        XCTAssertEqual(validations[4] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "passwordConfirmation", validationError: .required_password_confirmation))
        XCTAssertEqual(validations[5] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", validationError: .password_not_match))
    }
}

extension SignUpComposerTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, createAccount: CreateAccountSpy) {
        let createAccountSpy = CreateAccountSpy()
        let sut = SignUpComposer.composeController(with: MainDispatchQueueDecorator(createAccountSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: createAccountSpy, file: file, line: line)
        return (sut, createAccountSpy)
    }
}
