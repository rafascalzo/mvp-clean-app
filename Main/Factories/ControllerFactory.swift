//
//  ControllerFactory.swift
//  Main
//
//  Created by Rafael Scalzo on 19/04/22.
//

import Foundation
import Domain
import UI
import Presentation
import Validation
import Data
import Infra

class ControllerFactory {
    
    static func makeSignUp(createAccount: CreateAccount) -> SignUpViewController {
        let controller = SignUpViewController()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, createAccount: createAccount, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp
        return controller
    }
}

// Proxy Design Pattern
class WeakVarProxy<T: AnyObject> {
    
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
