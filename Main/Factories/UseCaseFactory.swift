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
    
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseURL = Environment.variable(for: .apiBaseURL)
    
    private static func makeURL(path: String) -> URL {
        return URL(string: "\(apiBaseURL)/\(path)")!
    }
    
    static func makeRemoteCreateAccount() -> CreateAccount {
        let remoteCreateAccount = RemoteCreateAccount(url: makeURL(path: "signup"), httpClientPost: httpClient)
        return MainDispatchQueueDecorator(remoteCreateAccount)
    }
}
