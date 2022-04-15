//
//  CreateAccountIntegrationTests.swift
//  CreateAccountIntegrationTests
//
//  Created by Rafael Scalzo on 15/04/22.
//

import XCTest
import Data
import Infra
import Domain

class CreateAccountIntegrationTests: XCTestCase {
    
    func test_create_account() {
        let url = URL(string: "http://localhost:80/bankapp/signup")!
        let alamofireAdapter = AlamofireAdapter()
        let sut = RemoteCreateAccount(url: url, httpClientPost: alamofireAdapter)
        let createAccountModel = CreateAccountModel(name: "João Augusto", email: "joaosaug@gmail.com", password: "not404", passwordConfirmation: "not404")
        let exp = expectation(description: "waiting")
        sut.create(account: createAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expect success but got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(account.name, createAccountModel.name)
                XCTAssertEqual(account.email, createAccountModel.email)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 15)
    }
}
