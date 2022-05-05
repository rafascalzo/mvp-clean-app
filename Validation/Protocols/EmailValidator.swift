//
//  EmailValidator.swift
//  Presentation
//
//  Created by Rafael Scalzo on 15/04/22.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
