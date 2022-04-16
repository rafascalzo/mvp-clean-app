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
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Name"))
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Email"))
    }
    
    func test_signup_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Password"))
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Password confirmation"))
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(message: "Password not match"))
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
        emailValidatorSpy.isValid = false
        sut.signUp(viewModel: makeSignUpViewModel(email: "invalid_email@mail.com"))
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(message: "Invalid email"))
    }
    
    func test_signUp_should_call_create_account_with_correct_values() {
        let createAccountSpy = CreateAccountSpy()
        let sut = makeSut(createAccount: createAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(createAccountSpy.createAccountModel, makeCreateAccountModel())
    }
    
    func test_signUp_should_show_error_message_if_create_account_fails() {
        let alertViewSpy = AlertViewSpy()
        let createAccountSpy = CreateAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, createAccount: createAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        createAccountSpy.completeWithError(.unexpected)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Error", message: "Something goes wrong"))
    }
}

extension SignUpPresenterTests {
    
    func makeSut(alertView: AlertView = AlertViewSpy(), emailValidator: EmailValidator = EmailValidatorSpy(), createAccount: CreateAccount = CreateAccountSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, createAccount: createAccount)
        return sut
    }
    
    func makeSignUpViewModel(name: String? = "any_name", email: String? = "any_email", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Validation failed", message: "\(fieldName) is required")
    }
    
    func makeInvalidAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Validation failed", message: message)
    }
}

class CreateAccountSpy: CreateAccount {
    
    var createAccountModel: CreateAccountModel?
    var completion: ((Result<AccountModel, DomainError>) -> Void)?
    
    func create(account: CreateAccountModel, completion: @escaping CreateAccountCompletion) {
        self.createAccountModel = account
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
}

class AlertViewSpy: AlertView {
    
    var viewModel: AlertViewModel?
    
    func showMessage(viewModel: AlertViewModel) {
        self.viewModel = viewModel
    }
}

class EmailValidatorSpy: EmailValidator {
    
    var isValid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
}
