//
//  SignUpFactory.swift
//  Main
//
//  Created by Rafael Scalzo on 19/04/22.
//

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra

class SignUpFactory {
    
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let remoteCreateAccount = RemoteCreateAccount(url: url, httpClientPost: alamofireAdapter)
        let presenter = SignUpPresenter(alertView: controller, emailValidator: emailValidatorAdapter, createAccount: remoteCreateAccount, loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
