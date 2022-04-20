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

public final class SignUpComposer {
    
    public static func composeController(with createAccount: CreateAccount) -> SignUpViewController {
        let controller = SignUpViewController()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, createAccount: createAccount, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp
        return controller
    }
}
