//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Rafael Scalzo on 16/04/22.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "any_name", email: String? = "any_email", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}
