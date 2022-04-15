//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Rafael Scalzo on 15/04/22.
//

import XCTest

struct SignUpViewModel {
    
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel : Equatable {
    var title: String
    var message: String
}

enum ValidationError: Error {
    case required_name, required_email, required_password, required_password_confirmation
    
    var message: String {
        switch self {
        case .required_name: return "Name is required"
        case .required_email: return "Email is required"
        case .required_password: return "Password is required"
        case .required_password_confirmation: return "Password confirmation is required"
        }
    }
}

class SignUpPresenter {
    
    private let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(viewModel: SignUpViewModel) {
        do {
            try validate(viewModel: viewModel)
        } catch let error {
            let validationError = error as! ValidationError
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: validationError.message))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) throws {
        if viewModel.name == nil || viewModel.name?.isEmpty ?? true {
            throw ValidationError.required_name
        } else if viewModel.email == nil || viewModel.email?.isEmpty ?? true {
            throw ValidationError.required_email
        } else if viewModel.password == nil || viewModel.password?.isEmpty ?? true {
            throw ValidationError.required_password
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation?.isEmpty ?? true {
            throw ValidationError.required_password_confirmation
        }
    }
}

class SignUpPresenterTests: XCTestCase {
    
    func test_signup_should_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Name is required"))
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Email is required"))
    }
    
    func test_signup_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password is required"))
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", password: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password confirmation is required"))
    }
}

extension SignUpPresenterTests {
    
    func makeSut() -> (SignUpPresenter, AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
}

class AlertViewSpy: AlertView {
    
    var viewModel: AlertViewModel?
    
    func showMessage(viewModel: AlertViewModel) {
        self.viewModel = viewModel
    }
}
