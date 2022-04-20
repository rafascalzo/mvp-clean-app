//
//  UseCaseFactory.swift
//  Main
//
//  Created by Rafael Scalzo on 19/04/22.
//

import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    
    static func makeRemoteCreateAccount() -> CreateAccount {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        return RemoteCreateAccount(url: url, httpClientPost: alamofireAdapter)
    }
}
