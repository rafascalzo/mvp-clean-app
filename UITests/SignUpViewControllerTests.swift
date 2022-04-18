//
//  SignUpViewControllerTests.swift
//  SignUpViewControllerTests
//
//  Created by Rafael Scalzo on 16/04/22.
//

import XCTest
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loading_view_protocol() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alert_view_protocol() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_save_button_calls_signUp_on_tap() {
        var signUpViewModel: SignUpViewModel?
        let signUpSpy: (SignUpViewModel) -> Void = { signUpViewModel = $0 }
        let sut = makeSut(signUp: signUpSpy)
        sut.saveButton.simulateTap()
        XCTAssertEqual(signUpViewModel, SignUpViewModel(name: sut.nameTextField.text, email: sut.emailTextField.text, password: sut.passwordTextField.text, passwordConfirmation: sut.passwordConfirmationTextField.text))
    }
}

extension SignUpViewControllerTests {
    
    func makeSut(signUp: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sut = SignUpViewController()
        sut.signUp = signUp
        sut.loadViewIfNeeded()
        return sut
    }
}

