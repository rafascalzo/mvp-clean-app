//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Rafael Scalzo on 15/04/22.
//

import XCTest
import Presentation
import Domain


class SignUpPresenterTests: XCTestCase {
    
    func test_signup_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Name"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Password"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe {viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Password confirmation"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe {viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(message: "Password not match"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_call_email_validator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel(email: "invalid_email@mail.com")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signup_should_show_error_message_if_invalid_email_is_provided() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe {viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(message: "Invalid email"))
            exp.fulfill()
        }
        emailValidatorSpy.isValid = false
        sut.signUp(viewModel: makeSignUpViewModel(email: "invalid_email@mail.com"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_call_create_account_with_correct_values() {
        let createAccountSpy = CreateAccountSpy()
        let sut = makeSut(createAccount: createAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(createAccountSpy.createAccountModel, makeCreateAccountModel())
    }
    
    func test_signup_should_show_error_message_if_create_account_fails() {
        let alertViewSpy = AlertViewSpy()
        let createAccountSpy = CreateAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, createAccount: createAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Something goes wrong"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        createAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_success_message_if_create_account_succeeds() {
        let alertViewSpy = AlertViewSpy()
        let createAccountSpy = CreateAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, createAccount: createAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Success", message: "Cheers! Account created"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        createAccountSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_loading_before_and_after_call_create_account() {
        let loadingViewSpy = LoadingViewSpy()
        let createAccountSpy = CreateAccountSpy()
        let sut = makeSut(createAccount: createAccountSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting2")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        createAccountSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
}

extension SignUpPresenterTests {
    
    func makeSut(alertView: AlertView = AlertViewSpy(), emailValidator: EmailValidator = EmailValidatorSpy(), createAccount: CreateAccount = CreateAccountSpy(), loadingView: LoadingView = LoadingViewSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, createAccount: createAccount, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
