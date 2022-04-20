//
//  SignUpComposer.swift
//  Main
//
//  Created by Rafael Scalzo on 20/04/22.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    
    public static func composeController(with createAccount: CreateAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUp(createAccount: createAccount)
    }
}
