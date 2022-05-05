//
//  SignUpComposer.swift
//  Main
//
//  Created by Rafael Scalzo on 20/04/22.
//

import Foundation
import Domain
import UI
import Presentation
import Validation
import Infra

public final class SignUpComposer {
    
    public static func composeController(with createAccount: CreateAccount) -> SignUpViewController {
        let controller = SignUpViewController()
        let validationComposite = ValidationComposite(validations: makeValidations())
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), createAccount: createAccount, loadingView: WeakVarProxy(controller), validation: validationComposite)
        controller.signUp = presenter.signUp
        return controller
    }
    
    public static func makeValidations() -> [Validation] {
        return [
            RequiredFieldValidation(fieldName: "name", validationError: .required_name),
            RequiredFieldValidation(fieldName: "email", validationError: .required_email),
            EmailValidation(fieldName: "email", validationError: .invalid_email, emailValidator: EmailValidatorAdapter()),
            RequiredFieldValidation(fieldName: "password", validationError: .required_password),
            RequiredFieldValidation(fieldName: "passwordConfirmation", validationError: .required_password_confirmation),
            CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", validationError: .password_not_match)
        ]
    }
}

