//
//  CreateAccount.swift
//  Domain
//
//  Created by rvs on 11/02/22.
//

import Foundation

public typealias CreateAccountCompletion = (Result<AccountModel, Error>) -> Void

public protocol CreateAccount {
    
    func create(account: CreateAccountModel, completion: @escaping CreateAccountCompletion)
}

public struct CreateAccountModel: Encodable {
    
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    
    public init(name: String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
        
    }
}
