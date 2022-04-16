//
//  CreateAccountSpy.swift
//  PresentationTests
//
//  Created by Rafael Scalzo on 16/04/22.
//

import Foundation
import Domain

class CreateAccountSpy: CreateAccount {
    
    var createAccountModel: CreateAccountModel?
    var completion: ((Result<AccountModel, DomainError>) -> Void)?
    
    func create(account: CreateAccountModel, completion: @escaping CreateAccountCompletion) {
        self.createAccountModel = account
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithAccount(_ account: AccountModel) {
        completion?(.success(account))
    }
}
