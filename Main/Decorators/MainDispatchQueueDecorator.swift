//
//  MainDispatchQueueDecorator.swift
//  Main
//
//  Created by Rafael Scalzo on 25/04/22.
//

import Foundation
import Domain

public final class MainDispatchQueueDecorator<T> {
    
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainDispatchQueueDecorator: CreateAccount where T: CreateAccount {
    
    public func create(account: CreateAccountModel, completion: @escaping CreateAccountCompletion) {
        instance.create(account: account) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
