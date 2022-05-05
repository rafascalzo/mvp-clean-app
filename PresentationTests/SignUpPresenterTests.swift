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
    
    func test_signup_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_signup_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Validation failed", message: validationSpy.error!.message))
            exp.fulfill()
        }
        validationSpy.simulate(error: .required_name)
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpPresenterTests {
    
    func makeSut(alertView: AlertView = AlertViewSpy(), createAccount: CreateAccount = CreateAccountSpy(), loadingView: LoadingView = LoadingViewSpy(), validation: Validation = ValidationSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, createAccount: createAccount, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
