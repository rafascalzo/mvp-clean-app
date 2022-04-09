//
//  RemoteCreateAccount.swift
//  Data
//
//  Created by Rafael Scalzo on 08/04/22.
//

import Foundation
import Domain

public final class RemoteCreateAccount {
    
    private let url: URL
    private let httpClientPost: HttpClientPost
    
    public init (url: URL, httpClientPost: HttpClientPost) {
        self.url = url
        self.httpClientPost = httpClientPost
    }
    
    public func create(createAccountModel: CreateAccountModel) {
        httpClientPost.post(to: url, with: createAccountModel.toData())
    }
}
