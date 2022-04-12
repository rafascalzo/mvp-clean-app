//
//  RemoteCreateAccount.swift
//  Data
//
//  Created by Rafael Scalzo on 08/04/22.
//

import Foundation
import Domain

public final class RemoteCreateAccount: CreateAccount {
    
    private let url: URL
    private let httpClientPost: HttpClientPost
    
    public init (url: URL, httpClientPost: HttpClientPost) {
        self.url = url
        self.httpClientPost = httpClientPost
    }
    
    public func create(account createAccountModel: CreateAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClientPost.post(to: url, with: createAccountModel.toData()) { error in
            completion(.failure(.unexpected))
        }
    }
}
