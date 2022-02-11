//
//  CreateAccount.swift
//  Domain
//
//  Created by rvs on 11/02/22.
//

import Foundation

typealias CreateAccountCompletion = (Result<AccountModel, Error>) -> Void

protocol CreateAccount {
    
    func create(account: CreateAccountModel, completion: @escaping CreateAccountCompletion)
}

struct CreateAccountModel {
    
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}
